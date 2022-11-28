# Create your grading script here

rm -rf student-submission/
git clone $1 student-submission
if [[ -f ./student-submission/ListExamples.java ]]; then
    echo "ListExamples was found in the repository."
else
    echo "ListExamples was not found in the repository."
    exit
fi 
cp TestListExamples.java ./student-submission
cp -r ./lib ./student-submission/lib
cd student-submission
set +e
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > compile-err.txt
# javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
# java -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > compile-err.txt
grep -B 1 "Error:" compile-err.txt > tests-success.txt
testMerge=$( grep -c "testMerge" tests-success.txt )
testFilter=$( grep -c "testFilter" tests-success.txt )
testTotal=$(($testMerge + $testFilter))
if [[ $testTotal -eq 0 ]]; then
    echo "Passed all tests! Score: 2/2"
    exit
fi
if [[ $testMerge -eq 1 ]]; then
    echo "Failed testMerge."
fi
if [[ $testFilter -eq 1 ]]; then
    echo "Failed testFilter."
fi
if [[ $testTotal -eq 1 ]]; then
    echo "Score: 1/2"
    exit
fi
if [[ $testTotal -eq 2 ]]; then
    echo "Score: 0/2"
    exit
fi
