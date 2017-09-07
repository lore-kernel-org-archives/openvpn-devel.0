References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <8f028968-1263-af79-4b49-863a202b9d93@...515...>
Date: Thu, 7 Sep 2017 15:17:10 +0300
MIME-Version: 1.0
In-Reply-To: <20170907081340.GG70062@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

On 07/09/2017 11:13, Gert Doering wrote:
> Hi,
>=20
> On Thu, Sep 07, 2017 at 11:04:01AM +0300, Samuli Sepp=E4nen wrote:
>> "Note that units which are configured for Restart=3D and which reach the
>> start limit are not attempted to be restarted anymore; however, they may
>> still be restarted manually at a later point, from which point on, the
>> restart logic is again activated."
>=20
> Which is not what I hoped for... "turn it off and leave it so" is non
> helpful (it might be a transient error preventing the startup).
>=20

Good point. Systemd seems to be able to adjust its restart behavior
depending on exit code of the main service process (i.e. OpenVPN) using
"RestartForceExitStatus" and "RsstartPreventExitStatus"[1]. Perhaps
these could be helpful in our case...

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <https://www.freedesktop.org/software/systemd/man/systemd.service.html>

