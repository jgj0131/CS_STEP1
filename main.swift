//
//  main.swift
//  cs_study
//
//  Created by jang gukjin on 03/04/2019.
//  Copyright © 2019 jang gukjin. All rights reserved.
//

import Foundation

// NAND 게이트
func nand(paramA : Bool, paramB: Bool)->Bool{
    let answer : Bool
    answer = paramA && paramB
    return !answer
}
var a : Bool = true
var b : Bool = true
print("NAND 게이트에 \(a)와 \(b)가 통과하면 \(nand(paramA: a, paramB: b))가 됩니다!")

// NOR 게이트
func nor(paramA : Bool, paramB: Bool)->Bool{
    let answer : Bool
    answer = paramA || paramB
    return !answer
}
a = false
b = false
print("NOR 게이트에 \(a)와 \(b)가 통과하면 \(nand(paramA: a, paramB: b))가 됩니다!")



// Int배열을 입력받아 String으로 바꿔주는 함수( 배열에는 1,0만 입력 가능 )
func array_int(_ array: [Int])->String?{
    var arr:[String]=[]
    for i in 0...array.count-1{
        if(array[i] == 1 || array[i] == 0){
            arr.append(String(array[i]))
        }else {
            print("배열을 다시 입력하시오")
            return nil
        }
    }
    let str = arr.joined()
    return str
}

// 1과0을 입력하면 true,false로 반환하는 함수
func int_bool(_ int : Int)->Bool?{
    if int == 1 {return true}
    else if int == 0 {return false}
    else {
        print("1과0만 입력하시오!")
        return nil
    }
}

// Bool을 Int로 변환하는 함수
func bool_int(_ bool : Bool)->Int{
    if bool == true { return 1 }
    else { return 0}
}

// 이진 덧셈기
// 반가산기 (Bool ver.)
func halfadder(_ bitA:Bool, _ bitB:Bool) -> [Bool]{
    let sum : Bool = bitA != bitB
    let carry : Bool = bitA && bitB
    return [carry, sum]
}
a = true
b = false
print(halfadder(a, b))

// 반가산기 (Int ver.)
func halfadder_int(_ bitA : Int, _ bitB : Int) -> [Int]?{
    if int_bool(bitA) == nil || int_bool(bitB) == nil{
        return nil
    }else{
        let bitA_bool = int_bool(bitA)
        let bitB_bool = int_bool(bitB)
        
        let sum : Bool = bitA_bool != bitB_bool
        let carry : Bool = bitA_bool! && bitB_bool!
        
        let sum_int = bool_int(sum)
        let carry_int = bool_int(carry)

        return [carry_int, sum_int]
    }
}
var a_num : Int = 1
var b_num : Int = 0
if halfadder_int(a_num, b_num) != nil{
    print(halfadder_int(a_num, b_num)!)
}


// 전가산기 (Bool ver.)
func fulladder(_ bitA:Bool, _ bitB:Bool, _ carry_in: Bool) -> [Bool]{
    let sum : Bool = bitA != bitB
    let carry_out : Bool
    if sum == true && carry_in == true { carry_out = true }
    else if bitA == true && bitB == true { carry_out = true }
    else { carry_out = false }
    let sum2 = sum != carry_in
    return [carry_out, sum2]
}
a = true
b = true
var c : Bool = true
print(fulladder(a,b,c))

// 전가산기 (Int ver.)
func fulladder_int(_ bitA:Int, _ bitB:Int, _ carry_in: Int) -> [Int]?{
    if int_bool(bitA) == nil || int_bool(bitB) == nil{
        return nil
    }else{
        let bitA_bool = int_bool(bitA)
        let bitB_bool = int_bool(bitB)
        let carry_in_bool = int_bool(carry_in)
        
        let sum : Bool = bitA_bool != bitB_bool
        let carry_out : Bool
        if sum == true && carry_in_bool == true { carry_out = true }
        else if bitA_bool == true && bitB_bool == true { carry_out = true }
        else { carry_out = false }
        let sum2 = sum != carry_in_bool
        
        let sum_int = bool_int(sum2)
        let carry_out_int = bool_int(carry_out)

        return [carry_out_int, sum_int]
    }
}
a_num = 1
b_num = 1
var c_num : Int = 1
if fulladder_int(a_num, b_num, c_num) != nil{
    print("\(a_num),\(b_num)이 입력되고, carry가 \(c_num)이면 \(fulladder_int(a_num, b_num, c_num)!)입니다")
}


// 미션2 전가산기
func fulladder_int2(_ byteA : [Int], _ byteB : [Int])->[Int]?{
    if byteA.count != byteB.count { return nil }
    else {
        var arr:[Int] = []
        let bit_half = halfadder_int(byteA[0], byteB[0])
        arr.append(bit_half![1])
        if byteA.count == 1 { // byteA, byteB에 원소가 1개씩일때
            arr.append(bit_half![0])
            return arr
        }
        else{
            let bit_full = fulladder_int(byteA[1], byteB[1], bit_half![0])
            arr.append(bit_full![1])
            if byteA.count == 2 { // byteA, byteB에 원소가 2개씩일때
                arr.append(bit_full![0])
                return arr
            }
            else { // byteA, byteB에 원소가 3개 이상일때
                for i in 2...byteA.count-1{
                    let bit_full = fulladder_int(byteA[i], byteB[i], bit_full![0])
                    arr.append(bit_full![1])
                }
                arr.append(bit_full![0])
                return arr
            }
        }
    }
}
let byteA:[Int] = [1]
let byteB:[Int] = [0]
print("\(byteA)와 \(byteB)를 더하면 \(fulladder_int2(byteA,byteB)!)가 된다.")

// 진법 변환기
/* 진수별 작성법
 2진수 : 0b0101
 8진수 : 0o1403
 10진수 : 32
 16진수 : 0x987
 */

let d1 = 4 // Int 형태의 10진수
let b1 = String(d1, radix:2) // 2진법으로 변환
print("\(d1)를(을) 2진법(String)으로 바꾸면 \(b1)")

let b2 = "101010" // String 형태일때
let d2 = Int(b2, radix:2)! // 10 진법으로 변환
print("String형태의 \(b2)를 10진법(Int)로 바꾸면 \(d2)")

// 10수 => 2진수
func dec2bin(_ decimal:Int)->[Int]{
    var arr : [Int] = []
    var input = decimal
    while input>=2{
        arr.append(input % 2)
        input = input/2
    }
    arr.append(input)
    return arr
}

let d3 = 10
print("\(d3)를(을) 2진수로 변환하면 \(dec2bin(d3))")

// 2진수 => 10진수
func bin2dec(_ bin:[Int])-> Int?{
    var dec : Int = 0
    for i in 0...bin.count-1{
        let bin_to_dec = pow(2,i)
        let result = NSDecimalNumber(decimal: bin_to_dec).intValue
        if bin[i] > 1{
            print("배열에는 1과0만 입력하세요!")
            return nil
        }else{
            dec = dec + (bin[i] * result)
        }
    }
    return dec
}

let b3 = [0,1,1,1]
if bin2dec(b3) != nil{
    print("\(b3)를 10진수로 변환하면 \(bin2dec(b3)!)")
}

