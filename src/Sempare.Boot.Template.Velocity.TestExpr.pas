(*%****************************************************************************
 *  ___                                             ___               _       *
 * / __|  ___   _ __    _ __   __ _   _ _   ___    | _ )  ___   ___  | |_     *
 * \__ \ / -_) | '  \  | '_ \ / _` | | '_| / -_)   | _ \ / _ \ / _ \ |  _|    *
 * |___/ \___| |_|_|_| | .__/ \__,_| |_|   \___|   |___/ \___/ \___/  \__|    *
 *                     |_|                                                    *
 ******************************************************************************
 *                                                                            *
 *                        VELOCITY TEMPLATE ENGINE                            *
 *                                                                            *
 *                                                                            *
 *          https://www.github.com/sempare/sempare.boot.velocity.oss          *
 ******************************************************************************
 *                                                                            *
 * Copyright (c) 2019 Sempare Limited,                                        *
 *                    Conrad Vermeulen <conrad.vermeulen@gmail.com>           *
 *                                                                            *
 * Contact: info@sempare.ltd                                                  *
 *                                                                            *
 * Licensed under the Apache License, Version 2.0 (the "License");            *
 * you may not use this file except in compliance with the License.           *
 * You may obtain a copy of the License at                                    *
 *                                                                            *
 *   http://www.apache.org/licenses/LICENSE-2.0                               *
 *                                                                            *
 * Unless required by applicable law or agreed to in writing, software        *
 * distributed under the License is distributed on an "AS IS" BASIS,          *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
 * See the License for the specific language governing permissions and        *
 * limitations under the License.                                             *
 *                                                                            *
 ****************************************************************************%*)
unit Sempare.Boot.Template.Velocity.TestExpr;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestVelocityExpr = class
  public
    [Test]
    procedure TestExprBool;
    [Test]
    procedure TestExprNum;
    [Test]
    procedure TestExprNumFloat;
    [Test]
    procedure TestExprStr;
    [Test]
    procedure TestSimpleVariable;
    [Test]
    procedure TestTernary;
    [Test]
    procedure TestInExpr;

  end;

implementation

uses
  Sempare.Boot.Template.Velocity;

procedure TTestVelocityExpr.TestSimpleVariable;
begin
  Velocity.parse('before <% abc %> after');
end;

procedure TTestVelocityExpr.TestTernary;
begin
  Assert.AreEqual('a', Velocity.Eval('<% true?''a'':''b'' %>'));
  Assert.AreEqual('b', Velocity.Eval('<% false?''a'':''b'' %>'));
end;

procedure TTestVelocityExpr.TestExprNum;
begin
  Velocity.parse('before <% a := 123 %> after ');
end;

procedure TTestVelocityExpr.TestExprNumFloat;
begin
  Velocity.parse('before <% a := 123.45 %> after ');
end;

procedure TTestVelocityExpr.TestExprStr;
begin
  Velocity.parse('before <% a := ''hello world'' %> after ');
end;

procedure TTestVelocityExpr.TestInExpr;
begin
  Assert.AreEqual('false', Velocity.Eval('<% 0 in [1,2,3] %>'));
  Assert.AreEqual('true', Velocity.Eval('<% 1 in [1,2,3] %>'));
  Assert.AreEqual('true', Velocity.Eval('<% 2 in [1,2,3] %>'));
  Assert.AreEqual('true', Velocity.Eval('<% 3 in [1,2,3] %>'));
  Assert.AreEqual('false', Velocity.Eval('<% 4 in [1,2,3] %>'));
  Assert.AreEqual('true', Velocity.Eval('<% ''hello world'' in [1,''hello world'',3] %>'));
  Assert.AreEqual('false', Velocity.Eval('<% ''hello'' in [1,''hello world'',3] %>'));
end;

procedure TTestVelocityExpr.TestExprBool;
begin
  Velocity.parse('before <% a := true %> after ');
  Velocity.parse('before <% a:= false %> after ');
  Velocity.parse('before <% a:= true and false %> after ');
  Velocity.parse('before <% a:= true or false %> after ');
  Velocity.parse('before <% a:= true and false or true %> after ');
end;

initialization

TDUnitX.RegisterTestFixture(TTestVelocityExpr);

end.
