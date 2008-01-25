Message-ID: <479936F2.3000204@...41...>
Date: Thu, 24 Jan 2008 18:10:10 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4797B53E.4020007@...41...>
	<1323691392.20080123234058@...449...>	<9e0cf0bf0801231453i796138cctb3ddb28d1c803c68@...278...>	<359159876.20080124000039@...449...>	<9e0cf0bf0801231507hf027b09jbc7a9cdae292f475@...278...>	<1235941264.20080124002142@...449...>	<977951940.20080124021820@...449...>
	<4797E84F.5080904@...41...> <938873501.20080124083722@...449...>
In-Reply-To: <938873501.20080124083722@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: Openvpn-devel@lists.sourceforge.net

Carsten Kr=FCger wrote:
> Hello James,
>
>  =20
>> Use ./domake-win to build OpenVPN on Windows (see comments as well in
>>    =20
>
> That file didn't exist in rc5, I found it in rc4.
>
>  =20

The domake script exists in the subversion repository:

http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn

however I see that it was not making it into the tarball via make dist. =20
I've committed a change that will fix this:  make dist will now build a=20
tarball with all of the subversion files + the usual "autoreconf -i -v"=20
generated files.

James


