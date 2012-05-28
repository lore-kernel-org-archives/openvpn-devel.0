Message-ID: <4FC36AAB.6050806@...515...>
Date: Mon, 28 May 2012 15:08:11 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20120527202737.GV1161@...1296...>
	<CAOazyz0LD6ykOFcxcRTvu95Sjkzcsg2+FxT7514Ki3+QW9Dbsw@...278...>
	<20120528075212.GW1161@...1296...>
In-Reply-To: <20120528075212.GW1161@...1296...>
Subject: Re: [Openvpn-devel] build revolution lost t_client test?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 28.05.2012 10:52, Gert Doering ha scritto:
> Hi
>
> On Sun, May 27, 2012 at 11:36:57PM +0300, Alon Bar-Lev wrote:
>> t_client.sh requires root/sudo privileges.
>> "make check" should not assume any special privilege.
>> Because of this it is removed from "make check".
>> You can still run this by hand or we can add special target such as
>> "make root-check" or similar.
> There was agreement by the developers to *have* this, and no explicit
> agreement to *remove* it - you got an ACK for the patch, but I'm fairly
> sure that it was not made clear that you removed t_client.sh functionality
> while moving stuff around, because otherwise you would have seen NAKs.

It seems 34cb91 removed this functionality without explicitly mention
anything about it. It was a massive patch that moved stuff around, which
is why this change went unnoticed. Somebody please apply Gert's patch or
provide an alternative patch, I'd need to setup connectivity tests for
my buildslaves, too.

I don't really care what the make target is called. It could even be an
entirely different target. Buildslaves could easily run "make check"
followed by "make root-check", "make connection-test" or whatever. If
nobody outside the core project is supposed to run the connectivity
tests, I think separating them from "make check" would make sense.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


