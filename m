MIME-Version: 1.0
In-Reply-To: <86da1d4c-d798-da76-9079-6037f0c1cd9a@...515...>
References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
	<51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
	<86da1d4c-d798-da76-9079-6037f0c1cd9a@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 19 May 2017 15:23:57 -0400
Message-ID: <CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, May 19, 2017 at 1:44 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> On 19/05/2017 17:50, David Sommerseth wrote:
>> On 19/05/17 16:28, Jonathan K. Bullard wrote:
>>> When I try to verify the signature on openvpn-2.3.16.tar.gz (using
>>> openvpn-2.3.16.tar.gz.asc) from the "Downloads" page [1], I get the
>>> following:
>>>
>>>      gpg: assuming signed data in `XXX/openvpn-2.3.16.tar.gz'
>>>      gpg: Signature made Thu May 18 16:56:48 2017 EDT using RSA key ID =
8CC2B034
>>>      gpg: Can't check signature: public key not found
>>>
>>> The signatures on openvpn-2.3.15.tar.gz (downloaded last week) and on
>>> openvpn-2.4.2.tar.gz both verify fine.
>>>
>>> I think this is because Samuli's new key's ID is not 8CC2B034, it is
>>> 40864578 (if I understand correctly what is meant by "ID".)
>>
>> Samuli have an old key (0x198D22A3, RSA-1024) and a new key (0x40864578,
>> RSA-2048).  He have switched to the new key and prefers to use that one.
>>
>> We decided just a few days ago that we will switch to use the
>> security@...515... key for signing the officially released tarballs.
>>
>>
>>> Is 8CC2B034 the "Security mailing list GPGP key" on the "GnuPG Public
>>> Key" page [2]?
>> The proper key is:
>> pub   4096R/0x12F5F7B42F2B01E7 2017-02-09 [expires: 2027-02-07]
>> Key fingerprint =3D F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
>> uid   OpenVPN - Security Mailing List <security@...515...>
>>
>> Which can also be found here:
>> <http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>
>>
>>
>>> The link on that page to that key is broken (and includes
>>> Javascript!).
>>
>> Yes!  I discovered the same issue and reported it internally a couple of
>> hours ago.  I expect it to be fixed in not too long.
>>
>
> Hi,
>
> Joomla did not seem to like the fact that file name was
> security@...2270... So I renamed it as security.key.asc. That
> seems to work fine.

Thanks!

> Right now the signature situation is a bit confusing, as 2.4.2 is still
> signed with my new key, and 2.3.16 is using the security@...515...
> key. That is all documented here, though:
>
> <https://openvpn.net/index.php/open-source/documentation/sig.html>

OK, I get that, but the key file from the link David provided (and
which was also in his reply to the email announcing 2.3.16):

 <http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>

is not identical to the "Security mailing list GPG key" I just
downloaded from the "sig" page.

Is that a problem?

(Sorry if this is something that's common knowledge.)

Best regards,

Jon

