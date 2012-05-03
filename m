Message-ID: <4FA27940.3080104@...1114...>
Date: Thu, 03 May 2012 14:25:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
In-Reply-To: <CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
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
To: Gauri Bhave <gaurib123@...277...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/05/12 12:21, Gauri Bhave wrote:
> Well that's the legacy that i got from the previous developer. So
> just wanted to know if it supports UTF8. And it will really help if
> you can point out the exact version's of OpenVPN access server and
> OpenVPN connect client which support UTF8 username's and
> Passwords.

OpenVPN Access Server and OpenVPN Connect Client are the commercial
offerings from OpenVPN Technologies.  We don't support them here, and
the codebase there are somewhat different from the OpenVPN Community
Edition we support here.  However, the Community Edition have all the
features as the Access Server/Connect Client have - and some more.

For the commercial support, please contact the company directly.

Otherwise, feel free to dig into the information about the Community
Edition of OpenVPN here:

<https://community.openvpn.net/openvpn>

There are some on-going works to update the Access Server and Connect
Clients to a newer codebase, based upon the community version.
However, there are no publicly known schedules for when or how this
will happen.  And we on the community side are not involved into those
decisions at all.

Having all that said, there has been done a lot in the community
edition to support UTF-8, especially on Windows.  If the commercial
versions have pulled in that support or not, or have implemented
something else; that we don't know anything about at all.  But I
suspect that the Access Server and Connect Client is currently not
UTF-8 capable on Windows.

There should also be no issues using the Community Edition on the
client side against an Access Server installation, if that is an
alternative.

I hope this answers your question better.


kind regards,

David Sommerseth




> On Thu, May 3, 2012 at 12:44 PM, Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>> wrote:
> 
> Hi,
> 
> On Thu, May 03, 2012 at 12:14:28PM +0530, Gauri Bhave wrote:
>> Can you tell me which version of openvpn started supporting utf8.
>> I am using openvpn-2.1_rc15 but all my utf8 characters get
>> converted to '_' (underscores), when i see the log on the server
>> side and AD gives
> me an
>> error authentication failed.
> 
> 2.3_alpha1
> 
> (Just as a side remark - I don't understand why anyone would want
> to use a release *candidate* of something that has been properly
> released over 3 years(!) ago - and the 2.1 train is now up to
> 2.1.4, and there is 2.2.2 as well...)
> 
> gert
> 
> -- USENET is *not* the non-clickable part of WWW!
> 
> //www.muc.de/~gert/ <http://www.muc.de/%7Egert/> Gert Doering -
> Munich, Germany gert@...1296... <mailto:gert@...1296...> 
> fax: +49-89-35655025 gert@...1297... 
> <mailto:gert@...1297...>
> 
> 
> 
> 
> ------------------------------------------------------------------------------
>
> 
Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond.
> Discussions will include endpoint security, mobile security and the
> latest in malware threats.
> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________ Openvpn-devel
> mailing list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ieT4ACgkQDC186MBRfroaiwCfUNxdN7fRmgPx4Zphf1JkEmwu
lKgAnR2E1MUZdU9qQLtaTvvt8uU+cDa3
=ZgFK
-----END PGP SIGNATURE-----

