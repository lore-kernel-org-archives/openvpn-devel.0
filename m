Message-ID: <4AE3580C.7080604@...41...>
Date: Sat, 24 Oct 2009 13:39:56 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20091023142219.GA30874@...1066...>
In-Reply-To: <20091023142219.GA30874@...1066...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Victor Wagner wrote:
> I've found out that string_mod family of function do very bad job
> with certificates with cyrillic characters in the subject.
> 
> As of OpenVPN 2.1_rc19 class CC_PRINT is determined by function
> isprint from ctype.h, which does wrong job if there was no setlocale
> call (and there is no setlocale call in the OpenVPN).
> 
> Moreover, all printable data except ones produced by X509_NAME_oneline 
> function is produced by ASN1_STRING_to_UTF8 functions and no one
> guaranties that current locale of openvpn process has UTF-8 codeset.
> 
> I've fixed this problem by defining new character class CC_MSB, which
> all bytes from UTF-8 multibyte sequence belong to, allow this
> character class everywhere where CC_PRINT is allowed  and include it
> into macro definition of  X509_NAME_CHAR_CLASS and
> COMMON_NAME_CHAR_CLASS
> 
> I think that it is enough for security purposes, because no shell would
> ever treat unicode codepoints above 128 as word or command separators.
> 
> And it gives me valid utf-8 string in the script variables and logs.
> 
> But may be there exist better solution.

Can you submit a patch (as an email attachment) with this fix?

My only concern would be if there are ways an attacker could use chars 
that are >= 128 to attack a shell or server-side auth script.

I think it would be better to have this turned off by default, but have
an option to enable it, like the no-name-remapping option in 2.1.

James


