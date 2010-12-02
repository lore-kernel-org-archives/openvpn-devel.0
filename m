Message-ID: <4CF7E102.6060700@...1114...>
Date: Thu, 02 Dec 2010 19:10:10 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTik4eydtMdKm7un1cbf6YvLUQi70OxjXaimqELR8@...278...>
	<AANLkTimTVn5xMKhr-jo5eF3Q2dJpGVDQmVanE9_kmyi9@...278...>
In-Reply-To: <AANLkTimTVn5xMKhr-jo5eF3Q2dJpGVDQmVanE9_kmyi9@...278...>
Subject: Re: [Openvpn-devel] PATCH: floating-tls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: blaise@...1426...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/10 18:44, Blaise Gassend wrote:
> Hi,
> 
> Didn't hear back from anybody. Is there really no interest at all in
> adding floating TLS?
> 

We discussed this patch on the developers meeting last week.  We
probably forgot to give an explicit feedback.

I have three concerns to this patch.

a) This *sounds* like a useful feature, I'm wondering *how* useful it is
for the broad audience of users.

b) What kind of security implications does this patch introduce?  When
mentioning TLS and changing a unique identifier instead of IP address
for determining where packets belongs, I do get nervous.

c) You enforce all new compiles to have this feature enabled by default.
 I personally would like to see it *disabled by default* and those users
who need it can enable it when compiling it.  If we reach the state were
the majority compile this with this feature enabled, we can consider
changing the default.


kind regards,

David Sommerseth


> 
> On Thu, Oct 21, 2010 at 8:25 PM, Blaise Gassend <blaise@...1426...> wrote:
>> Hi,
>>
>> To allow seamless roaming of our robots at willowgarage
>> (http://willowgarage.com), I have put together a patch that allows TLS
>> connections to float. I would like to put this patch up for critique
>> and possible inclusion into mainline openvpn. The general approach has
>> been to prefix a few bytes at the start of each packet which contain
>> an opcode and a unique identifier (random number) for the session.
>> That identifier is used instead of the IP address for determining
>> which connection the packet belongs to.
>>
>> Regards,
>> Blaise
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz34QAACgkQDC186MBRfrriGACZAWYZc7/HAjavAYQrRL4eLCK/
eagAnRlaZjFiQu7jV0LfQgRIEEzGiy8v
=i4cd
-----END PGP SIGNATURE-----

