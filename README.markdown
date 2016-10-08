# bond-metric

A set of functions for calculating bond benchmarks.

[![Build Status](https://travis-ci.org/LukasBeaton/bond-metric.svg?branch=master)](https://travis-ci.org/LukasBeaton/bond-metric)
[![Coverage Status](https://coveralls.io/repos/github/LukasBeaton/bond-metric/badge.svg)](https://coveralls.io/github/LukasBeaton/bond-metric?branch=master)

NOTE: Coverage Status is actually at 100%. There is a bug with Simplecov/Travis CI where the Ruby CSV library is included in the coverage report and it is degrading the report. Please see the break down of the Coverage Report for more details by clicking on the "Coverage Status" badge above. 

----------

## Requirements
- Ruby 2.2.1

NOTE: It may work with other versions, however, Ruby 2.2.1 is the only version that has been tested to date.

----------

## Run in a console
#### 1) Clone the GitHub repo
```
$git clone https://github.com/LukasBeaton/bond-metric
```

#### 2) Install gems dependencies
```
$bundle install
```

#### 3) Install bond-metric gem
```
$bundle exec rake install
```

#### 4) Run in console
```
$ irb
irb(main):001:0> require 'bond_metric'
=> true
irb(main):002:0> file = '/Users/lukas/bond-metric/spec/fixtures/bonds_good.csv'
=> "/Users/adknowledgeuser/bond-metric/spec/fixtures/bonds_good.csv"
irb(main):003:0> BondMetric.print_spread_to_benchmark(file)
bond,benchmark,spread_to_benchmark
C1,G1,1.60%
C2,G3,2.80%
=> nil
irb(main):004:0> BondMetric.print_spread_to_curve(file)
bond,spread_to_curve
C1,1.22%
C2,2.98%
=> nil
```
	$ gem install bond-metric

----------
	
## Functions

#### BondMetric#generate_spread_to_benchmark(absolute_file_path)
**Description:** This function analyzes a list of corporate and government bonds. It will determine the benchmark government bond for each corporate bond and compute the yield spread.

**Parameters:** This function accepts an absolute file path as a parameter.
e.g. */home/lukas/bond-list.csv*

The CSV must be in the following format.

```
bond,type,term,yield
C2,corporate,15.2 years,8.30%
C1,corporate,10.3 years,5.30%
G3,government,16.3 years,5.50%
G1,government,9.4 years,3.70%
G2,government,12 years,4.80%
```

**Output:** It responds with the yield spread for each coporate bond in CSV. For example:

```
bond,benchmark,spread_to_benchmark
C1,G1,1.60%
C2,G3,2.80%
```

NOTE: If you are running this command from an irb console and want to see a properly formatted response in stdout, then use the equivalent print function instead.

	irb(main):001:0>BondMetric#generate_spread_to_benchmark(absolute_file_path)

----------

#### BondMetric#generate_spread_to_curve(absolute_file_path)
**Description:** This function analyzes a list of corporate and government bonds. It will determine two benchmark government bonds for each corporate bond and compute the spread to the government bond curve.

**Parameters:** This function accepts an absolute file path as a parameter.
e.g. */home/lukas/bond-list.csv*

The CSV must be in the following format.

```
bond,type,term,yield
C2,corporate,15.2 years,8.30%
C1,corporate,10.3 years,5.30%
G3,government,16.3 years,5.50%
G1,government,9.4 years,3.70%
G2,government,12 years,4.80%
```

**Output:** It responds with the yield spread for each coporate bond in CSV. For example:

```
bond,spread_to_curve
C1,1.22
C2,2.98%
```

NOTE: If you are running this command from an irb console and want to see a properly formatted response in stdout, then use the equivalent print function instead.

	irb(main):001:0>BondMetric#generate_spread_to_curve(absolute_file_path)

## Technical Choices

#### Ruby 2.2.1
I chose to use Ruby 2.2.1 because it is one of the latest stable versions of Ruby that is also stable on Travis CI.

### Testing, TDD, and Continuous Integration
I chose Rspec as my preferred library for writing tests. I have found Rspec to be more robust and performant that Test Unit and have been using it for significantly longer since switching from Test Unit 6 years ago (2010).

I write code using TDD. Yes, I actually write the test first, watch it fail, and then make it pass. These rapid iterations of RED/GREE/REFACTOR are evident in my many small commits. Objects are also tested in isolation as much as possible to achieve a loose coupling in the test suite.

From the get-go I integrated Travis CI to run my test suite automatically when I push my Master branch to origin. The GREEN badge at the top of the project assures me that my code is always healthy.

I used Simplcov and Coveralls to ensure that the test coverage of the project does not degrade over time. It is currently 100% and I aim to keep it that way.

### Structs
I used Ruby's Struct library to model my entities. For the small scale of this library it seemed like a very simple way to create a class object without the overhead of actually creating a class. It also allowed be to be explicit about the attributes on my entities and allowed me to easily create convenience methods and validations.

### Reserved Words
I noticed that the values "yield" and "type" are used as headers in the CSV file. I explicitly avoided using these words, as much as possible, in my implementation. For instance, using these words as field names can cause issues in Ruby applications, especially with Rails and ActiveRecord.

###Basis Points
Intead of storing the yield as a decimal and or float I decided to store it as an Integer in a field called 'basis_points' on the Struct::Bond entity. I did this to eliminate any potential rounding error when calculating the benchmarks.

## Improvements

### Optimization
The report generation could be optimized. It currently runs as O(n^2) but could be optimized to run as O(n) with a small enhancement. 

A binary search could even be used to bring the time complexity down to O(log(n)).

----------

## Contributing to bond-metric
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2016 Lukas Beaton. See LICENSE.txt for
further details.


