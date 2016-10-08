# bond-metric

A set of functions for calculating bond benchmarks.

[![Build Status](https://travis-ci.org/LukasBeaton/bond-metric.svg?branch=master)](https://travis-ci.org/LukasBeaton/bond-metric)
[![Coverage Status](https://coveralls.io/repos/github/LukasBeaton/bond-metric/badge.svg)](https://coveralls.io/github/LukasBeaton/bond-metric?branch=master)
[![Gem Version](https://badge.fury.io/rb/bond-metric.svg)](https://badge.fury.io/rb/bond-metric)

----------

## Requirements
- Ruby 2.2.1

NOTE: It may work with other versions, however, Ruby 2.2.1 is the only version that has been tested to date.

----------

## Install
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
