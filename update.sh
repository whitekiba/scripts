#!/bin/bash
branch="1.5"
ordner=( $(ls | grep -v `basename $0`) )
built=""
for i in "${ordner[@]}"; do
	cd $i
	if [ "$1" == "--install" ]; then
		echo "Installing module: $i"
		if [ -d "build" ]; then
			cd build
			sudo make install
			cd .. && rm -rf build
		else
			echo "$i was not built. ignoring"
		fi
	else 
		echo "Updating folder: $i"
		if [ -d "build" ]; then
			rm -rf build
		fi
		if [ "`git status --porcelain -b`" != "## $branch" ]; then
			echo "Switching branch to $branch"
			git branch $branch
			git checkout $branch
		fi
		git pull &> /dev/null
		if [ $? -eq 1 ]; then
			git checkout master
			git pull &> /dev/null
			git branch -D $branch
			echo "Branch $branch not available. Going back to master"
		fi
		if [ "$1" == "--build" ]; then
			mkdir build && cd build
			cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` -DEXECUTEBROWSER_INCLUDE_DIR=../../kdev-executebrowser
			if [ -f "Makefile" ]; then
				echo "Building: $i"
				make -j5
				if [ $? -eq 0 ]; then
					echo "Build completed"
					built="$built $i"
					#make install #das lassen wir erst mal
					cd ..
				else
					echo "Errors occured"
					cd .. && rm -rf build
				fi
			else
				echo "Failed configuring: $i"
				cd .. && rm -rf build
			fi
		fi
	fi
	cd ..
done
if [ "$1" == "--build" ]; then
	echo "Packages built: $built"
fi
