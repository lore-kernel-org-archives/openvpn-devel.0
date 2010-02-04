Message-ID: <4B6AEEBB.1020601@...1114...>
Date: Thu, 04 Feb 2010 16:58:51 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B6564E1.1000506@...515...> <4B6A9823.8010800@...1114...>
	<20100204142914.GT857@...1296...>
In-Reply-To: <20100204142914.GT857@...1296...>
Subject: Re: [Openvpn-devel] New development process ready
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/02/10 15:29, Gert Doering wrote:
[snip]
>>   - Patches on the mailing list should preferably be start with [PATCH]
>>     in the subject field.  (This will not cause a direct rejection, but
>>     I might miss a contributed patch when parsing the mailing list)
>>   - Patches sent to me directly *will* be rejected.  All patches must be
>>     public and will be discussed in public.
>>   - If a lot of merge conflicts turns up when applying the patch, I will
>>     most likely reject the patch and ask for a new patch which applies
>>     cleanly.
> 
> Overall, I think these rules make lots of sense.
> 
> I'd add another rule
> 
>     - All new code must be written following the OpenVPN coding conventions
>       (code indenting, scratch memory handling with "gc", etc.)
> 
> Long-term maintenance of code written with different indent styles and
> different ideas about memory management in different places is a 
> nightmare.
> 

Very good point!  I agree to this one.  But this also hits another need,
a public developer documentation which describes this.  Anyway, the
documentation need should be discussed in the meeting today as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktq7rcACgkQDC186MBRfrqezQCcCrE2UfcTX6fmKvJX5Mv9+3IH
ItIAoKXgknhOumtFtp3AxeD+AZJeDdGc
=bN/y
-----END PGP SIGNATURE-----

