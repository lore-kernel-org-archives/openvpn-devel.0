Message-ID: <529EF77C.5020603@...68...>
Date: Wed, 04 Dec 2013 10:35:56 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <528B8225.3040206@...515...>
	<1384882574-28242-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1384882574-28242-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] English language? Re: [PATCH] Support non-ASCII
 characters in Windows tmp path
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

Am 19.11.2013 18:36, schrieb Heiko Hund:
> Get the temporary path from the system as UCS-2 and convert it to
> UTF-8 and return that for internal use.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>


> +      msg (M_WARN, "Could not find a suitable temporary directory."
> +          " (GetTempPath() failed).  Consider to use --tmp-dir");
> +      return NULL;
> +    }
> +
> +  if (WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) > sizeof (tmpdir))
> +    {
> +      msg (M_WARN, "Could not get temporary directory. Path is too long."
> +          "  Consider to use --tmp-dir");

I think when touching the code, we ought to change all occurrences to
"Consider using --tmp-dir".

Native speakers or linguists correct me, but since most usage references
I found were "consider + object" (object often a noun), the -ing form
would have to be used here.

The closest I found is on
<http://www.merriam-webster.com/dictionary/consider> which has "He
seriously considered changing careers." (under Examples), among lots of
"consider + noun" patterns.


