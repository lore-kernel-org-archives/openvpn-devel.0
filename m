MIME-Version: 1.0
References: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
In-Reply-To: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 17 Apr 2020 17:16:56 -0400
Message-ID: <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

 IHi,

On Fri, Apr 17, 2020 at 8:47 AM Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>
> The OpenVPN community project team is proud to release OpenVPN 2.4.9. It
> can be downloaded from here:
>
> <https://openvpn.net/community-downloads/>

I'm having trouble verifying 2.4.9.tar.gz with GPG. I'm pretty
clueless about gpg, but I think it may not have been signed with the
correct key.

When I try to verify the signature:

$ gpg -v --verify openvpn-2.4.9.tar.gz.asc openvpn-2.4.9.tar.gz
gpg: Signature made Fri Apr 17 07:18:44 2020 EDT
gpg:                using RSA key 333D46306CF9D9F1F630DB8D96AEC408005D6BB4
gpg: Can't check signature: No public key

But I have the Security Mailing List GPG key (downloaded 2019-10-31)
and used it to verify earlier downloads [1]. I downloaded a fresh copy
of the key, but it is identical to my old one. I tried re-importing:

$ gpg --import security-key-2019.asc
gpg: key 12F5F7B42F2B01E7: "OpenVPN - Security Mailing List
<security@...515...>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

Which I interpret as "the identical key was already loaded".

$ gpg --list-public-keys --keyid-format LONG
pub   rsa4096/12F5F7B42F2B01E7 2017-02-09 [SC] [expires: 2027-02-07]
      F554A3687412CFFEBDEFE0A312F5F7B42F2B01E7
uid [ unknown] OpenVPN - Security Mailing List <security@...515...>

This is with gpg (GnuPG) 2.2.3, libgcrypt 1.8.1

Any suggestions?

Jon Bullard

[1] 2.4.8 verifies OK (although the key has now expired):

$ gpg --verify openvpn-2.4.8.tar.gz.asc  openvpn-2.4.8.tar.gz
gpg: Signature made Wed Oct 30 08:49:58 2019 EDT
gpg:                using RSA key 82175D35AA8D0E8BDE5F4F9E5DC351805ACFEAC6
gpg: Good signature from "OpenVPN - Security Mailing List
<security@...515...>" [unknown]
gpg: Note: This key has expired!
Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
     Subkey fingerprint: 8217 5D35 AA8D 0E8B DE5F  4F9E 5DC3 5180 5ACF EAC6

