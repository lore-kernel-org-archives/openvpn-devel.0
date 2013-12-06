Message-ID: <52A19700.8030500@...68...>
Date: Fri, 06 Dec 2013 10:21:04 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <CAFHpkQE_3xeGuVe+Ouydz70WN1cdhm2dwHsibV+e-ysyp2fGpg@...278...>
In-Reply-To: <CAFHpkQE_3xeGuVe+Ouydz70WN1cdhm2dwHsibV+e-ysyp2fGpg@...278...>
Subject: [Openvpn-devel] NAK on uninitialized handle fix (serious issue on
	Win 8.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 04.12.2013 14:12, schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD:
> Hello!
>=20
> I confirm issue described here: https://forums.openvpn.net/topic13246.html
> also, I confirm that it is due to random handle value (which somehow
> was null before Win 8.1 was released)
>=20
> also, I do not understand why we should check "err" handle on
> INVALID_HANDLE_VALUE, it will fail anyway on WriteFile, that check is
> useless.
>=20
> I do not insist on being perfect, if someone has better idea how to
> solve https://forums.openvpn.net/topic13246.html - I do not mind.
>=20
> I can make git pull request from
> https://github.com/chipitsine/openvpn/commit/3987bd0e035b653a5017c5eccbd5=
4eaf22746852
> if it's better.
>=20
> people encounter problems on Win 8.1 (well, just couple of people
> here, we are running openvpn with tens of customers on Win 8.1), I
> beleive it is serious issue, please consider release of openvpn.
>=20
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index afda8ca..3ec5758 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -62,7 +62,6 @@ get_console_input_win32 (const char *prompt, const
> bool echo, char *input, const
>    err =3D get_orig_stderr ();
>=20
>    if (in !=3D INVALID_HANDLE_VALUE
> -      && err !=3D INVALID_HANDLE_VALUE
>        && !win32_service_interrupt (&win32_signal)
>        && WriteFile (err, prompt, strlen (prompt), &len, NULL))
>      {

Ilya, I am sorry to have to veto this for now.

NAK from me, this introduces a new bug.  If GetStdError() inside
get_orig_stderr() fails, you will end up with err =3D=3D
INVALID_HANDLE_VALUE here, so the check err !=3D INVALID_HANDLE_VALUE must
not be removed.

Similarly, if get_orig_stderr() returns NULL, you must not call
WriteFile() either, so how about an additional "&& err !=3D NULL" here?

I don't have Win 8.1 and cannot test that.

> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 6848425..acc7977 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -454,12 +454,12 @@ close_syslog ()
>=20
>  #ifdef WIN32
>=20
> -static HANDLE orig_stderr;
> +static HANDLE orig_stderr =3D INVALID_HANDLE_VALUE;
>=20
>  HANDLE
>  get_orig_stderr (void)
>  {
> -  if (orig_stderr)
> +  if (orig_stderr !=3D INVALID_HANDLE_VALUE)
>      return orig_stderr;
>    else
>      return GetStdHandle (STD_ERROR_HANDLE);
>=20

NAK on this, too.  It exchanges one bug for another.

The STD_ERROR_HANDLE interface has, according to
<http://msdn.microsoft.com/en-us/library/windows/desktop/ms683231%28v=3Dvs.=
85%29.aspx>,
two special values, INVALID_HANDLE_VALUE (as error marker) and NULL (as
marker for "we don't have a console").

I think that there needs to be a separate/new "orig_stderr_is_valid"
variable, or at least the if (...) else needs to be

if (orig_stderr !=3D NULL && orig_stderr !=3D INVALID_HANDLE_VALUE)
...

