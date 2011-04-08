MIME-Version: 1.0
In-Reply-To: <1302262805-23686-3-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
	<1302262805-23686-3-git-send-email-davids@...1347...>
Date: Fri, 8 Apr 2011 18:48:02 +0300
Message-ID: <BANLkTi=ADS7e=5RFG+dQ9qXLozWxmMBOow@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Use %SystemRoot% instead of
 hard-coded C:\WINDOWS for temp directory path
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Apr 8, 2011 at 2:40 PM, David Sommerseth <davids@...1347...> wrote:
> +
> + =C2=A0envptr =3D getenv(SYS_PATH_ENV_VAR_NAME);
> + =C2=A0if( !envptr ) {
> + =C2=A0 =C2=A0/* This indicates something is really wrong with the Windo=
ws
> + =C2=A0 =C2=A0 * environment, and we shouldn't try to start OpenVPN in t=
his case
> + =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0msg (M_FATAL, "Could not find %%%s%% environment variable",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 SYS_PATH_ENV_VAR_NAME);
> + =C2=A0 =C2=A0return NULL; /* Just in case M_FATAL doesn't exit() */
> + =C2=A0}
> +
> + =C2=A0openvpn_snprintf(tmpdir, 256, "%.249s\\Temp", envptr);
> + =C2=A0msg (M_WARN, "Could not find %%TEMP%% or %%TMP%% environment vari=
ables. =C2=A0"
> + =C2=A0 =C2=A0 =C2=A0 "Falling back to %s. =C2=A0Consider to use --tmp-d=
ir", tmpdir);
> =C2=A0 return tmpdir;
> =C2=A0}

Why something wrong with Windows?
This is incorrect.
Also, there should be no warning, as it perfectly standard location.
And I don't see ExpandEnvironmentVariables() usage, I expected to have
something to expand %SystemRoot%.

