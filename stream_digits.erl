#!/usr/bin/env escript
%%!
%% -*- coding: utf-8 -*-
%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
-module(stream_digits).
-mode('compile').

%% stream_digits: produce binary data on stdout.

-export([main/1]).

-type data() :: any().
-type state() :: #{yielder => fun((data()) -> data())
                  ,data => data()
                  ,succ => fun((state()) -> state())
                  }.


%% API

main (_) ->
    loop(#{yielder => fun sqrt/1
          ,data => 1
          ,succ => fun sqrt_succ/1
          }).

%% Internals

loop (State=#{yielder := Yield
             ,succ := Succ
             }) ->
    emit(Yield(State)),
    loop(Succ(State)).

emit (Term) ->
    Bin = term_to_binary(Term),
    io:format("~s", [Bin]).


sqrt (#{data := N}) ->
    math:sqrt(N).

sqrt_succ (State) ->
    State#{data => 1 + maps:get(data, State)}.

%% End of Module.
