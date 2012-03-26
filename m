MIME-Version: 1.0
In-Reply-To: <20120326095049.GO1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
Date: Mon, 26 Mar 2012 12:15:06 +0200
Message-ID: <CAOazyz2YYdfVYekhQEZu_sFXwXa7nRx5s3M=M2NhdHegZqt8Bw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 11:36:30AM +0200, Gert Doering wrote:
>> buildbot tried to build openvpn after David's merge yesterday, and failed
>> miserably. =C2=A0To see what happened I tried to reproduce on my FreeBSD=
 7.4
>> build slave, and found this, in a fresh git clone:
>>
>> gert@...1703...:/home/gert$ git clone git://openvpn.git.sourceforge.net/=
gitroot/openvpn/openvpn.git
>> ...
>> gert@...1703...:/home/gert/openvpn$ autoreconf -vi
>> autoreconf-2.68: Entering directory `.'
>> autoreconf-2.68: configure.ac: not using Gettext
>> autoreconf-2.68: running: aclocal -I m4
>> autoreconf-2.68: configure.ac: tracing
>> autoreconf-2.68: configure.ac: not using Libtool
>> autoreconf-2.68: running: /usr/local/bin/autoconf-2.68
>> configure.ac:328: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
>> =C2=A0 =C2=A0 =C2=A0 If this token and others are legitimate, please use=
 m4_pattern_allow.
>> =C2=A0 =C2=A0 =C2=A0 See the Autoconf documentation.
>> configure.ac:329: error: possibly undefined macro: AC_LIBTOOL_RC
>> configure.ac:330: error: possibly undefined macro: AC_PROG_LIBTOOL
>> autoreconf-2.68: /usr/local/bin/autoconf-2.68 failed with exit status: 1
>
> OK, David had an idea: this machine did not have libtool installed
> ("because we didn't need it before").

Right.
Usually you do autoreconf -ivf && ./configure && make dist at
development machine or central build server and send the tarball to
build machines, this way you don't need to install the autotools
components on all build machines.

>
> I have now installed libtool 2.2.10, and with that, "autoreconf -vi"
> does not return an error anymore.
>
>
> "configure" still fails looking for "libdl", though.

Yes, this results of strange development procedure, merge first then test..=
. :)

Can you please send me the config.log?
I will fix that.

Thanks for testing!

Alon.

