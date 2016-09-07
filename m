Message-ID: <57D00E6E.1010700@...1147...>
Date: Wed, 07 Sep 2016 14:56:14 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>	<20160907094304.GG78279@...1296...>	<f362e0a3-56ff-887d-c85e-dbad0d110109@...2080...>
	<20b3d262-ed34-cbde-8b03-3bccd8ebd3d8@...515...>
In-Reply-To: <20b3d262-ed34-cbde-8b03-3bccd8ebd3d8@...515...>
Subject: Re: [Openvpn-devel] Dropping Windows Vista / XP support?
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
To: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

On 07/09/16 14:15, Samuli Sepp=E4nen wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 07/09/16 11:43, Gert Doering wrote:
>>> Hi,
>>>
>>> On Wed, Sep 07, 2016 at 12:18:17PM +0300, Samuli Sepp=E4nen wrote:
>>>> We have already dropped XP support from OpenVPN Git "master". I
>>>> think now is the time to drop official XP support altogether, but
>>>> to maintain Vista support util the next tap-windows6 release.
>>> Oh, regarding Vista support: I noticed that major open source
>>> projects (like chrome) have already dropped Vista support - so I
>>> think dropping Vista for 2.4 should be OK.
>> I agree.  I believe the majority of most users upgraded to Win7 from
>> Vista, as Vista was a slow giant beast compared to Win7.  Those left
>> on Vista are probably not the kind of users interested in setting up
>> VPNs - and if they do, it would probably be one of the more commercial
>> offerings than configuring your own client.
>>
>> Put Vista and XP in the same "support category", which basically means
>> OpenVPN 2.3 and we'll see how long we are willing to officially
>> support 2.3.
> Maintaining Windows Vista support will be tricky without extra effort,
> as it enforces strict driver signing requirements like Windows 7, but
> lacks SHA2 support. This is not a showstopper for the user-space
> components (openvpn, openssl, etc), which just give the "Unknown
> publisher" warning. However, if we need to fix something in
> tap-windows6, the new driver will only have a SHA2 signature, and Vista
> will thus refuse to install and load it to the kernel.
>
> Windows XP is easier to support, as it allows loading of unsigned
> kernel-mode code without putting the operating system to "test mode"; it
> will just complain about "Unknown publisher".
>
> We could try to beg for a SHA1 code-signing certificate from Digicert
> using their support system. However, I will try to get some download
> figures for I00x and I60x installers before we go down that route.
>

we could consider a quick&dirty method:

XP/Vista -> NDIS5 only
7+ -> NDIS 6 only

I can't see why M$ would not allow SHA1 signed NDIS5 drivers anymore...
It would mean that the OpenVPN 2.3 code base needs to be remain=20
compatible with NDIS5 and 6, as it is now.

JJK


