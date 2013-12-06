MIME-Version: 1.0
In-Reply-To: <52A19700.8030500@...68...>
References: <CAFHpkQE_3xeGuVe+Ouydz70WN1cdhm2dwHsibV+e-ysyp2fGpg@...278...>
	<52A19700.8030500@...68...>
Date: Fri, 6 Dec 2013 16:23:38 +0600
Message-ID: <CAFHpkQE92DkVKo8x5hT7s-251EANt7zF1kbZFx1Ez8QXLJBsbg@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] NAK on uninitialized handle fix (serious issue
 on Win 8.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="KOI8-R"
Content-Transfer-Encoding: quoted-printable
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2013/12/6 Matthias Andree <matthias.andree@...68...>:
> Am 04.12.2013 14:12, schrieb =E9=CC=D8=D1 =FB=C9=D0=C9=C3=C9=CE:
>> Hello!
>>
>> I confirm issue described here: https://forums.openvpn.net/topic13246.ht=
ml
>> also, I confirm that it is due to random handle value (which somehow
>> was null before Win 8.1 was released)
>>
>> also, I do not understand why we should check "err" handle on
>> INVALID_HANDLE_VALUE, it will fail anyway on WriteFile, that check is
>> useless.
>>
>> I do not insist on being perfect, if someone has better idea how to
>> solve https://forums.openvpn.net/topic13246.html - I do not mind.
>>
>> I can make git pull request from
>> https://github.com/chipitsine/openvpn/commit/3987bd0e035b653a5017c5eccbd=
54eaf22746852
>> if it's better.
>>
>> people encounter problems on Win 8.1 (well, just couple of people
>> here, we are running openvpn with tens of customers on Win 8.1), I
>> beleive it is serious issue, please consider release of openvpn.
>>
>> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
>> index afda8ca..3ec5758 100644
>> --- a/src/openvpn/console.c
>> +++ b/src/openvpn/console.c
>> @@ -62,7 +62,6 @@ get_console_input_win32 (const char *prompt, const
>> bool echo, char *input, const
>>    err =3D get_orig_stderr ();
>>
>>    if (in !=3D INVALID_HANDLE_VALUE
>> -      && err !=3D INVALID_HANDLE_VALUE
>>        && !win32_service_interrupt (&win32_signal)
>>        && WriteFile (err, prompt, strlen (prompt), &len, NULL))
>>      {
>
> Ilya, I am sorry to have to veto this for now.
>
> NAK from me, this introduces a new bug.  If GetStdError() inside

if GetStdError() inside will fail, it means we do not have proper error han=
dle.
we fail in that case, no problem. what else can we do ?

> get_orig_stderr() fails, you will end up with err =3D=3D
> INVALID_HANDLE_VALUE here, so the check err !=3D INVALID_HANDLE_VALUE must
> not be removed.

ok, if get_orig_stderr returns INVALID_HANDLE_VALUE, what is difference bet=
ween

if( err !=3D INVALID_HANDLE_VALUE && !WriteFile(err,....)

and

if(!WriteFile(err,...))


?


>
> Similarly, if get_orig_stderr() returns NULL, you must not call
> WriteFile() either, so how about an additional "&& err !=3D NULL" here?

if you call WriteFile with NULL handle, it will fail, the entire "if"
will fail, it is not problem

>
> I don't have Win 8.1 and cannot test that.

be carefull with testing.

here are tens of customers with Win 8.1, however only couple of them
experience issues with "cannot read management password"
I was not able to reproduce it myself (but I eyewitness it and I
confirm that initilizing "orig_stderr" variable with some proper value
resolves issue)

>
>> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
>> index 6848425..acc7977 100644
>> --- a/src/openvpn/error.c
>> +++ b/src/openvpn/error.c
>> @@ -454,12 +454,12 @@ close_syslog ()
>>
>>  #ifdef WIN32
>>
>> -static HANDLE orig_stderr;
>> +static HANDLE orig_stderr =3D INVALID_HANDLE_VALUE;
>>
>>  HANDLE
>>  get_orig_stderr (void)
>>  {
>> -  if (orig_stderr)
>> +  if (orig_stderr !=3D INVALID_HANDLE_VALUE)
>>      return orig_stderr;
>>    else
>>      return GetStdHandle (STD_ERROR_HANDLE);
>>
>
> NAK on this, too.  It exchanges one bug for another.
>
> The STD_ERROR_HANDLE interface has, according to
> <http://msdn.microsoft.com/en-us/library/windows/desktop/ms683231%28v=3Dv=
s.85%29.aspx>,
> two special values, INVALID_HANDLE_VALUE (as error marker) and NULL (as
> marker for "we don't have a console").
>
> I think that there needs to be a separate/new "orig_stderr_is_valid"
> variable, or at least the if (...) else needs to be
>
> if (orig_stderr !=3D NULL && orig_stderr !=3D INVALID_HANDLE_VALUE)
> ...
>
> -------------------------------------------------------------------------=
-----
> Sponsored by Intel(R) XDK
> Develop, test and display web and hybrid apps with a single code base.
> Download it for free now!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D111408631&iu=3D/4140/ostg=
.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

