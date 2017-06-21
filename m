Message-ID: <7ba5f9c16f138ec7e90c015fb813c240.squirrel@...2257...>
In-Reply-To: <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
Date: Wed, 21 Jun 2017 16:42:35 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> On 21/06/17 13:48, Jonathan K. Bullard wrote:
>> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
>> wrote:
>>> The OpenVPN community project team is proud to release OpenVPN 2.4.3.
>>> It
>>> can be downloaded from here:
>>>
>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>
>> Hi. Thanks for this release.
>>
>> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
>> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
>> fails with:
>>
>> $ gpg2 -v --verify /XXX/openvpn-2.4.3.tar.gz.asc
>>
>> gpg: armor header: Version: GnuPG v1
>> gpg: assuming signed data in '/XXX/openvpn-2.4.3.tar.gz'
>> gpg: Signature made Wed Jun 21 06:19:19 2017 EDT
>> gpg:                using RSA key D72AF3448CC2B034
>> gpg: using subkey D72AF3448CC2B034 instead of primary key
>> 12F5F7B42F2B01E7
>> gpg: using pgp trust model
>> gpg: BAD signature from "OpenVPN - Security Mailing List
>> <security@...515...>" [unknown]
>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>
>> The SHA256 ofopenvpn-2.4.3.tar.gz is
>>      84a01aa3df0c12a3552ca3baaa39d700137b5bce4b6de683fe87fb79bfa5df0b
>>
>> The SHA256 of openvpn-2.4.3.tar.gz.asc is
>>      695afa06fcf94f9e8bd2ee63267332d14e52fe24dd58c470e42dafbea371e437
>>
>> The files were downloaded from
>> https://openvpn.net/index.php/open-source/downloads.html at about
>> 10:24 UCT today from the New York City area.
>>
>> For reference, here is the output from verifying 2.3.17:
>>
>> $ gpg2 -v --verify
>> /Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz.asc
>>
>> gpg: armor header: Version: GnuPG v1
>> gpg: assuming signed data in
>> '/Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz'
>> gpg: Signature made Wed Jun 21 06:18:55 2017 EDT
>> gpg:                using RSA key D72AF3448CC2B034
>> gpg: using subkey D72AF3448CC2B034 instead of primary key
>> 12F5F7B42F2B01E7
>> gpg: using pgp trust model
>> gpg: Good signature from "OpenVPN - Security Mailing List
>> <security@...515...>" [unknown]
>> gpg: WARNING: This key is not certified with a trusted signature!
>> gpg:          There is no indication that the signature belongs to the
>> owner.
>> Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B
>> 01E7
>>      Subkey fingerprint: B596 06E2 D8C6 E10B 80BE  2B31 D72A F344 8CC2
>> B034
>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>
>> Any ideas or suggestions?
>
> I believe it is Cloudflare playing tricks on us again.
>
> Attached are the proper signature files and below a list of the SHA256
> checksums:
>
> d300029416b045666f2dc957bdde407ba97894428b5ad8433df789e793ccc1d3
> openvpn-2.3.17.tar.xz
> b206065f4a1720c022fde710c0449b5b25e9dda8ca2911a82bacf21b9fcb4e29
> openvpn-2.3.17.tar.xz.asc
> 7aa86167a5b8923e54e8795b814ed77288c793671f59fd830d9ab76d4b480571
> openvpn-2.4.3.tar.xz
> 9f5f089f4a4b3e270ddb53cb0b689f4c0bad89d7e2ee08a1d4666e7ab869f210
> openvpn-2.4.3.tar.xz.asc
>
> This is based on the files I've already pushed to the Fedora builder
> (koji), which

I have the following sums:

af806c47623aa1d8246cf0790984766f61c8d0a63ea0b04127ff5c6c65e46088=20
openvpn-2.3.17.tar.gz
d300029416b045666f2dc957bdde407ba97894428b5ad8433df789e793ccc1d3=20
openvpn-2.3.17.tar.xz
cee3d3ca462960a50a67c0ebd186e01b6d13db70275205663695152c9aca8579=20
openvpn-2.4.3.tar.gz
15e15fc97f189b52aee7c90ec8355aa77469c773125110b4c2f089abecde36fb=20
openvpn-2.4.3.tar.xz

So 2.3.17 seems fine but what about 2.4.3? What is the real final check
sum for openvpn-2.4.3.tar.gz and openvpn-2.4.3.tar.xz?

Thanks,
Simon


