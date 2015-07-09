Message-ID: <559E2283.2030609@...515...>
Date: Thu, 09 Jul 2015 10:28:03 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>	<5593EBF6.4060203@...1114...>	<1896EA4F53C84141B287C36403D7DE21@...1853...>	<20150701144158.GD382@...1296...>
	<55963DC2.7060104@...515...>
In-Reply-To: <55963DC2.7060104@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net


>> Hi,
>>
>> On Wed, Jul 01, 2015 at 03:05:44PM +0100, debbie10t@...277... wrote:
>>> Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.1.12,
>>> 104.28.0.12
>>> Connecting to swupdate.openvpn.org
>>> (swupdate.openvpn.org)|104.28.1.12|:443... connected.
>> Something interesting is going on.  I thought it might be related to
>> the two different IP addresses, and maybe one has the file and one
>> does not - but it works for both from here...
>>
>> Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.0.12|:4=
43... connected.
>> openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D>]   1.72M  1.06MB/s   in 1.6s
>>
>> Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.1.12|:4=
43... connected.
>> openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D>]   1.72M  1.04MB/s   in 1.6s
>>
>> funny.
>>
>> Samuli, can you investigate?
> Sorry for the delay, did not check my emails yesterday.
>
> The 404 errors are typically happen if CloudFlare caches a 404 error
> from one of our download servers before the release files have
> propagated to it. As usual, I tested all the download links so that
> should _not_ be the case here. Nevertheless, I cleared the caches for
> this particular file.
>
> As for the TLS/SSL issues - I'll tell the guys at the office to have a
> look. I'm not aware of any changes at the CloudFlare end, but I'm not in
> the loop, either.
This might be the culprit for the TLS/SSL issues:

<https://community.centminmod.com/threads/cloudflare-universal-ssl-incompat=
ible-with-winxp-internet-explorer-8-browsers.1577/>

We have received reports that downloads from Windows XP don't work,=20
either. We will probably have to move the downloads to a domain which=20
does not use ECC.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


