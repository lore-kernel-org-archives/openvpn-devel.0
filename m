Message-ID: <4FD72D0F.706@...1114...>
Date: Tue, 12 Jun 2012 13:50:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-9-git-send-email-arne@...1227...>
	<CAHyOtRkFiz0aKO=FPLPsFXQg1EcxBMRwytVXt=6jfaP8jkgcrQ@...278...>
	<4FD237E3.2030605@...1227...>
In-Reply-To: <4FD237E3.2030605@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 8/8] Android platform specific changes.
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
To: Arne Schwabe <arne@...1227...>
Cc: Adriaan de Jong <adriaan@...1475...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/06/12 19:35, Arne Schwabe wrote:
> Am 07.06.12 18:44, schrieb Adriaan de Jong:
>> Hi Arne,
>> 
>> Could you please split this patch up a little further? As it is,
>> it performs a number of functions, which, although related to
>> Android would be easier to ack if they were separate.
>> 
>> Am I correct in noting that you use  management_query_user_pass()
>> to send queries across the management interface? If so, that begs
>> an open question to the community: is there a better way of
>> communicating across the management interface?
>> 
> Yes. At the moment almost all information is passed with 
> management_query_user_pass, I have no split up the patch further
> since we should first discussed the best way to pass information
> around. (See also the lengthy discussion when I first submitted an
> Android patch)

Your splitting in this round has been very good.  But it would be good
if patch 8 and maybe some of 7 could be split up a bit more.  Small
contained changes are far easier to review.  And it might be easier to
do modifications later on, if needed too.

One thing though, which I don't like so much is that you "abuse"
management_query_user_pass() for passing other types of data.  That
makes it harder to understand what you are doing and why.  When
reviewing I wondered for a little while why you where doing so much
management user/pass stuff on the client - until I saw what you
populated the user_pass structs with.

Would it be possible to rework the management_query_* stuff to have a
more generic API?  Where you could pass over the information you need
to pass and then keep the management_query_user_pass() for
username/password stuff.  This will help understanding the overall
code far better.  The management_query_user_pass() may surely use a
more flexible/generic backend, to avoid having code duplication.

I haven't been able to completely comprehend all you do in your patch
yet, so it might be more things too.  But this is at least a starter
of some feedback.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/XLQ0ACgkQDC186MBRfrp8fgCgg0mTKsbYpghVPB8Msiqv8Hhr
vn0AnA9COKbvR3EGOaL5NRmbEUdVryNP
=rtwU
-----END PGP SIGNATURE-----

