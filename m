Message-ID: <4F072D07.7060602@...1114...>
Date: Fri, 06 Jan 2012 18:19:03 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1320075008.29689.31.camel@...1520...>
	<4EAF0EFD.6060106@...1114...>
	<1323712625.31471.4.camel@...1520...>
	<4F071FD7.3060201@...1114...>
	<1325868040.2547.19.camel@...1520...>
In-Reply-To: <1325868040.2547.19.camel@...1520...>
Subject: Re: [Openvpn-devel] [PATCH] adding support for systemd tty console
 wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Frederic Crozat <fcrozat@...1519...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 06/01/12 17:40, Frederic Crozat wrote:
> Le vendredi 06 janvier 2012 à 17:22 +0100, David Sommerseth a écrit :
>> On 12/12/11 18:57, Frederic Crozat wrote:
>>> Le lundi 31 octobre 2011 à 22:11 +0100, David Sommerseth a écrit :
>>>> On 31/10/11 16:30, Frederic Crozat wrote:
>> [...snip...]
>>
>> Hey again, and thanks for this great rework!  I've looked through it, and
>> it looks a lot better now.  However ...
>>
>>>> e) Consider to make use of openvpn_execve_check() or
>>>> openvpn_execve() instead of the popen() - or make a popen() variant
>>>> which got similar error controls to popen() as openvpn_execve*()
>>>> functions.  I also think that this execution should honour the
>>>> --script-security setting (which is implicitly checked for with
>>>> openvpn_execve())
>>
>> I like the approach of the openvpn_popen().  However, there are a few things.
>>
>> +              if (pipe(pipe_stdout) == 0) {
>> +		      pid = fork ();
>> +		      if (pid == (pid_t)0) /* child side */
>> +			{
>> +			  close(pipe_stdout[0]);
>> +			  dup2(pipe_stdout[1],1);
>> +			  execve (cmd, argv, envp);
>> +			  exit (127);
>> +			}
>> +		      else if (pid < (pid_t)0) /* fork failed */
>> +			;
>>                        ^^^^^  No error message if fork() fails?
>>                               And is the (pid_t) typecasting really needed?
> 
> Well, I stole the code from openvpn_execve function ;))
> I'm ok to change it, but it would be better for both function to stay
> similar, I think.

Well, now you got me into looking deeper :) ... First of all, there might
be^W^W are code paths in openvpn which isn't pretty.  And we should fix up
that as we find them.

I'm still in the opinion that not reporting that the execution isn't proper
behaviour.  Even though, it's not likely that fork() fails often, unless
the system is low on memory or RLIMIT_NPROC is exceeded.  But informing
that the execution failed is still important for debugging.

I'd say, let's at least add an error message here, using M_ERR.  That way,
we'll get the errno message returned as well.  I'll take care of posting a
proper fix for openvpn_execve().  You may disregard my (pid_t) comment for now.

>> +		      else /* parent side */
>> +			{
>> +                            ret=pipe_stdout[0];
>> +			    close(pipe_stdout[1]);
>> +			}
>> +	      }
>>
>> And:
>>
>> +  else
>> +    {
>> +      msg (M_WARN, "openvpn_popen: called with empty argv");
>> +    }
>>
>> This should probably be M_FATAL and not M_WARN.  If openvpn_popen()
>> receives an empty argv array, it most likely is due to very bad
>> programming.  So halting execution is quite appropriate in my eyes.
> 
> Again, I stole this part from openvpn_execve, but I'll change it to
> M_FATAL.

I'll send a fix for this as well, in regards to openvpn_execve()

>> In get_console_input_systemd() you do:
>>
>> +  *input = 0;
>>
>> I think it would be better to do: CLEAR(*input) instead.  Just setting
>> the first byte to 0, will not solve any leak possibilities.  An
>> alternative is to use memset() directly, which the CLEAR() macro uses
>> (see basic.h:47), but we prefer to use CLEAR() over memset() directly.
> 
> done (and I've also fixed some missing spaces in various location).
> 
> See the new version attached.

Goodie!  I presume you did some compile and sanity testing before
submitting the patch, so that it won't bite our compile farm :)  I think we
have a F15 or F16 box (which uses systemd) in the farm, so we can enable
systemd features on that box.


kind regards,

David Sommerseth

