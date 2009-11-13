Message-ID: <4AFD59A1.2090507@...1114...>
Date: Fri, 13 Nov 2009 14:05:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091023142219.GA30874@...1066...>
	<4AE3580C.7080604@...41...>	<20091026081943.GA29659@...1066...>
	<4AFC3F83.4090900@...41...>	<20091112175924.GA10462@...1066...>	<4AFC530C.9080303@...1114...>
	<20091113122836.GA6902@...1066...>
In-Reply-To: <20091113122836.GA6902@...1066...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/11/09 13:28, Victor Wagner wrote:
> On 2009.11.12 at 19:25:16 +0100, David Sommerseth wrote:
> 
>>> no-name-remapping  has side effects, i.e. disables system method of
>>> script execution. 
>>
>> I'd have to disagree here.  OpenVPN should not change the default
>> behaviour at all, as that can break a lot of already implemented
>> installations if the default remapping goes away.  And forcing values to
>> stay inside the 7bit ASCII region is most likely the expected behaviour
>> as well.
> 
> I doubt so.
> 
> If you don't believe me, ask someone whose native language is French or
> German and who has characters with umlauts in his name - does he like
> this character to be replaced with underscore.

You are almost talking to one of those right now, I've basically grown
up using CP850, CP865, ISO-8859-1, ISO-8859-2 and UTF-8.  I've even
worked in companies since late 90s where charset conversion between all
of the above (and even EBCDIC) was crucial for day-to-day business.

> Even for Western Europe restricting character set of certificates to
> 7-bit is the source of problem, not to mention rest of world, where 
> any name would be replaced by string of underscores.
> 
> If someone want to limit characters allowed in the certificates, 
> it should be done on the CA level, not when parsing certificates.
> 
> On this level only reason to map characters is to prevent common
> mistakes in the shell script. Characters outside of ASCII range never
> can be misinterpreted by shells, so they should be  allowed.

But UTF-8 with multibyte characters might be, as they use more than one
byte per character.  It is easy to say that this won't be a security
issue with shells, but have you validated all shells on all platforms
OpenVPN supports to check for this?   Not all shells or programs do
handle well characters above the 7th bit (char >= 128), unfortunately!
I've experienced this on some embedded systems which is using busybox.

>>> Really, I think than name remapping shouldn't be applied to environment
>>> variables at all. May be for command line arguments should be protected
>>> this way. But people who use environment variables typically are clever
>>> enough to  handle shell special characters.
>>
>> I am willing to agree with you to some extent here, but OpenVPN cannot
>> change the current default behaviour of remapping.  This would have to
>> be thought of when this feature was initially implemented in OpenVPN,
>> now it is too late to change the defaults.
> 
> It is possible to add ADDITIONAL configuration directive such as
> --allow-unicode-in-names, which doesn't  have such side-effect as no-name-remapping
> does now.
> 
> But I think that this should be enabled by default. If someone cannot
> handle normal letters, he can disable them.

I do not agree to this.  Because, still too few considers the
implications of more than 7bit ASCII.  You are more likely to get in
trouble when the application is initially based on this scenario and
then changing to a broader scope.  Characters above the 7th bit are not
necessarily "normal" letters on all systems.

>> Unfortunately, not many thinks about characters outside the standard
>> 7bit ASCII.  I've even experienced developers who got non-ASCII
> 
> Just all Russia, all Japan and all China.
> 
> We just got too tired of persuading english speaking developers, that
> world is somewhat bigger than Northern America  and
> often prefer to fork and maintain our own localized version of software.

I agree, that this is a struggle.  But as long as the OpenVPN has been
on the marked for almost a decade, changing the defaults in such basics
can really break a lot of installations.  And doing that will harm the
reputation OpenVPN already have in regards to stability.

I do agree with you that introducing support for a broader set of
characters (8bit/UTF-8) is important to implement, and OpenVPN does
indeed need that!  Thus, your patch is important here!  But I disagree
that this must be done as default.

It should preferably, IMHO, be a runtime parameter and people who then
need it can enable it, and if they get troubles *they know why* because
*they* did that change.  And then they will be more able to fix that
according to their own time schedule and feature need, not when an
OpenVPN release forces every one to adopt.

When a broad part of the users have tested this over time, used it in
production environment and bugs connected to this is fixed ... then we
can consider to change the default behaviour, which normally would be
done in connection to a new major release.  But doing that change now,
that is simply too early.  It's even not a topic which has been
discussed much since I joined the mailing lists, not even on the IRC
channel.

Summary: I agree that we need this support, but don't change the default
behaviour now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr9WZwACgkQDC186MBRfrrhggCghUIv9fIC23J026kPavAH6mOR
hCgAn2CrLG0Y5/sOiP+sFgOK4yHF1y0F
=GP8d
-----END PGP SIGNATURE-----

