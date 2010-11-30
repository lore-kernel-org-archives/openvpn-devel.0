Message-ID: <4CF51D5B.4090905@...68...>
Date: Tue, 30 Nov 2010 16:50:51 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4CED2879.2030009@...1432...>
In-Reply-To: <4CED2879.2030009@...1432...>
Subject: Re: [Openvpn-devel] use extv3 extensions such as subjectAltName as
 common_name
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

Am 24.11.2010 16:00, schrieb Markus Koetter:
> Hi,
> 
> attached is a patch which allows using the extv3 extension of a 
> certificate as common name with email address.
> Email addresses are more likely to be unique than the common name, and 
> the environment forced me to use the subjectAltName extv3 extension for 
> authentication.
> So, there is already a need for this.

NAK on the patch:

1. unsafe use of strncpy (remember that strncpy does not NUL terminate if
there's no room!), and

2. without reading ASN1_STRING_to_UTF8() docs, I do not believe that the ASN
extraction is safe in itself.  There is no check for embedded NULs, and this
needs to be checked whenever you convert between NUL-terminated C-strings and
pointer/length strings and vice versa.  There have been prior vulnerabilities,
such as CVE-2009-2666.

Make sure that the extraction reports failure (aka "return false;") and the
caller deals with that in case there are embedded NULs, IOW strlen() != ia5.size.

For safer example code, see, for instance, the strlen vs. length comparison at
<http://gitorious.org/fetchmail/fetchmail/blobs/846ffbb938c7ecf6819a5c3b844adf306bf87f02/socket.c#line682>

-- 
Matthias Andree

