#Tests for Usernames.ps1 script functions
#Pester tests

Invoke-Pester .\Usernames.tests.ps1

BeforeAll {

#check if item is in given list
#helper function for In-Both
function InList {
    [CmdletBinding()]
    param (
        [#item
        [Parameter(Mandatory=$true)]
        [object]
        $item],

        [# list
        [Parameter(Mandatory=$true)]
        [array]
        $list]
    )
        if ($List.Contains($item)) {
            $true 
        }
        else {
            $false
        }
}

#returns if list is empty, false otherwise
function Empty? {
    [CmdletBinding()]
    param (
        [# Given list to check
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list]
    )
    if ($list -eq 0) {
        $true 
    }
    else {
        $false
    }
}


#return list objects in both $list1 and $list2
# if none, returns nothing
function InBoth {
    [CmdletBinding()]
    param (
        [# list1
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list1],

        [#list2
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list2]
    )
    #list to store objects in both $list1 and $list2
    $listBoth=new-object system.collections.arrayList
    foreach ($object in $list1) {
        if (InList -item $object -list $list2)
            {
                #add names in both $list1 and $list2 to $List_Both
                $listBoth.Add($name)
        }
     } 
        Empty? -list $listBoth
        Write-Host $listBoth
}

}

Describe "InList tests" {
    It "Returns <expected>" -ForEach @(
        @{ List = @();
            Item = "1";
            Expected = $false
        }
        @{
            List = @(1,2);
            Item = "1";
            Expected = $false
        }
        @{
            List = @(1,2);
            Item = 1;
            Expected = $true
        }
        @{
            List = @(2,1);
            Item = 1;
            Expected =$true
        }

    ) {
        InList -item $item -list $list | Should -Be $expected 
    }
}


Describe "Empty?" {
    It "Returns <expected> (<list>)" -ForEach @(
        @{ list = @(); Expected = $true}
        @{ list = @(1,2); Expected = $false}
        @{ list = @(1); Expected = $false}
        @{ list = @(1,2,3,4,5,6); Expected = $false}
    ) {
        Empty? -list $list | Should -Be $expected
    }
}

Describe "InBoth tests" {
    Context "Two empty lists" {
        It "Should return nothing" {
            $list1 = @()
            $list2 = @()
            InBoth -list1 $list1 -list2 $list2 | Should -Be
        }
    }
    Context "First list is empty" {
        It "Should return nothing" {
            $list1 = @()
            $list2 = @(1,2,3)
            InBoth -list1 $list1 - list2 $list2 | Second -Be
        }

    }
    Context "Second list is empty" {
        It "Should return nothing" {
            $list1 = @(1,2,3)
            $list2 = @()
            InBoth -list1 $list1 - list2 $list2 | Second -Be
        }

    }
    Context "Both lists have one element in common" {
        It "Should return list with common element" {
            $list1 = @(1,2,3)
            $list2 = @(1,5,6,7)
            InBoth -list1 $list1 -list2 $list2 | Should -Be @(1)
        }
    }
    Context "Both lists have multiple elements in common" {
        It "Should return list with all common elements" {
            $list1 = @(1,2,3,4,5)
            $list2 = @(2,4,5,6,7)
            InBoth -list1 $list1 -list2 $list2 | Should -Be @(2,4)
        }

    }
}
