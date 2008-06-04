Message-ID: <4846448F.1090209@...41...>
Date: Wed, 04 Jun 2008 01:30:23 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20080523132547.GB10263@...1101...>
In-Reply-To: <20080523132547.GB10263@...1101...>
Subject: Re: [Openvpn-devel] Still incorrect common name extraction
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
To: Openvpn-devel@lists.sourceforge.net

Heikki Kallasjoki wrote:
> The OpenSSL-based common name extraction code in current revision (2965)
> of the BETA21 branch is still incorrect in the cases where the extracted
> field is the first one in the DN:
>
> extract_x509_field_ssl:
>   int lastpos = -1;
>   int tmp = -1;
>   ...
>   do {
>     lastpos = tmp;
>     tmp = X509_NAME_get_index_by_NID(x509, nid, lastpos);
>   } while (tmp > 0);
>
> When there is only one common name field in the DN and it is the first
> field, the first call of X509_NAME_get_index_by_NID will return the
> index 0, at which point the loop will terminate, leaving -1 in lastpos
> and causing the extract_x509_field_ssl function to fail. Changing the
> test to "tmp > -1" fixes the bug, since X509_NAME_get_index_by_NID will
> return -1 if the field is not found.
>
> (This sort of situation happens with cacert.org client certificates,
> where the subject name is of the form
> "/CN=Real Name/emailAddress=email@...1100...".)
>
>
>   

A fix for this has been committed:

------------------------------------------------------------------------
r2980 | james | 2008-06-04 00:17:53 -0600 (Wed, 04 Jun 2008) | 6 lines
Changed paths:
   M /branches/BETA21/openvpn/ssl.c

Fixed an issue in extract_x509_field_ssl where the extraction
would fail on the first field of the subject name, such as
the common name in:

  /CN=foo/emailAddress=foo@...1106...

------------------------------------------------------------------------

James



