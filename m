Message-ID: <4AFC530C.9080303@...1114...>
Date: Thu, 12 Nov 2009 19:25:16 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091023142219.GA30874@...1066...>
	<4AE3580C.7080604@...41...>	<20091026081943.GA29659@...1066...>
	<4AFC3F83.4090900@...41...> <20091112175924.GA10462@...1066...>
In-Reply-To: <20091112175924.GA10462@...1066...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(let's try to get this into the mailing list as well, sorry about that)

On 12/11/09 18:59, Victor Wagner wrote:
> On 2009.11.12 at 10:01:55 -0700, James Yonan wrote:
> 
>> Victor Wagner wrote:
>>> On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:
>>>
>>>> Can you submit a patch (as an email attachment) with this fix?
>>> Attached
>>>
>>> This patch also contains X509_NAME_oneline replacement, which handles
>>> MSB characters.
>>>
>>> I've not checked if this patch applies cleanly to unmodified source.
>>> I've just diffed original 2.1_rc19 source, imported in our subversion
>>> repository with current working copy and removed all irrelevant chunks.
>>
>> Thanks for putting this together.
>>
>> I'm a bit concerned about changing any of the remapping behavior unless  
>> no-name-remapping is specified.  I see that in some areas, you test the  
>> no-name-remapping flag before you modify existing behavior, but in other  
>> areas such as my_X509_NAME_oneline, X509_NAME_CHAR_CLASS, and  
>> COMMON_NAME_CHAR_CLASS you don't.
> 
> Problem is that existing behavoir seems to be designed without non-ascii
> alphabets in mind.
> 
> I think that "preserving existing behavoir" is "exporting alpabetic
> characters as they are". Since it is quite hard to distinguish between
> "alphabetic" and "non-alphabetic" outside of ASCII range, and no shell
> use non-ascii as separators (which is primary reason of remapping),
> I've considered safe way to treat all 8-bit characters as alphabetic.
> 
> no-name-remapping  has side effects, i.e. disables system method of
> script execution. 

I'd have to disagree here.  OpenVPN should not change the default
behaviour at all, as that can break a lot of already implemented
installations if the default remapping goes away.  And forcing values to
stay inside the 7bit ASCII region is most likely the expected behaviour
as well.

> So, all non-latin-writting users would face choice - either 
> use their native language and loose some functionality of openvpn
> or have full fuctionality and loose native languge.
> 
> Really, I think than name remapping shouldn't be applied to environment
> variables at all. May be for command line arguments should be protected
> this way. But people who use environment variables typically are clever
> enough to  handle shell special characters.

I am willing to agree with you to some extent here, but OpenVPN cannot
change the current default behaviour of remapping.  This would have to
be thought of when this feature was initially implemented in OpenVPN,
now it is too late to change the defaults.

To get the behaviour you would like to implement, I am in favour of
adding a configuration parameter which enables that when _explicitly_
requested.  That's the best way how to avoid breaking already existing
installations.

> Moreover, if script is written in some better language than shell (i.e.
> perl, tcl on even is a C program, which should be probably considered
> worse language, as it is prone of buffer overflows), or for dlopened
> plugin same remapping rules are applied.

Trust me, it's not that easy with non-ascii characters.  It depends on
the locale setup, and in some cases which character set the file is
saved as (I've spent hours debugging a Perl script which looked 100%
correct, but it was saved as a file with ISO-8859-1 and not UTF-8, so
Perl then processed all data as ISO-8859-1.  Even more fun is this when
the file is saved as plain ASCII).  And Python is also a nightmare in
regards to character sets outside the standard ASCII range (7bit).

And if you don't know C well, of course you will get buffer overflows as
well.  But if you expect multi-byte input, you should also be able to
handle that wihtout overflow issues, already from the design and
implementation phase.  Being sloppy with the design and implementation
gives flaws in most programming and script languages.  And this is why I
favour forcing data to stay inside the 7bit ASCII region.  If you know
what you are doing, you'll know which config option to enable in OpenVPN
as well.

Unfortunately, not many thinks about characters outside the standard
7bit ASCII.  I've even experienced developers who got non-ASCII
characters in their names, and they forgot about 8bit and multi-byte
characters when implementing solutions processing names.

So having to enable characters outside the 7bit ASCII region explicitly
is most likely a better approach, IMHO.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8UwkACgkQDC186MBRfrpb+wCdE+umDv+3FpLO1LYlocBA+X57
7rsAn3o1vPMOHLSgfEfInPFot3aXi4T8
=Zboj
-----END PGP SIGNATURE-----

