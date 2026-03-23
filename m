Date: Mon, 23 Mar 2026 13:16:25 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <acEvGXr-sF2vipwR@...2685...>
References: <ab9xsPqPbK_jLNF2@...3014...>
MIME-Version: 1.0
In-Reply-To: <ab9xsPqPbK_jLNF2@...3014...>
Subject: Re: [Openvpn-devel] [PATCH] ssl_verify_openssl: use official
 ASN1_STRING_ API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Mar 22, 2026 at 04:36:00AM +0000, Rudi Heitbaum via Openvpn-devel wrote:
> ASN1_STRING are now opaque types in OpenSSL 4.x — the internal data and
> length fields are no longer directly accessible. Use the accessor API
> instead. Accessors have been available since OpenSSL 1.1.0
> 
> The ASN1_STRING_length accessor is already in use, but not consistently
> applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
> which allows for successful build of OpenSSL 4.x

Also pushed this to Gerrit as https://gerrit.openvpn.net/c/openvpn/+/1584 to
give it the full buildbot treatment.

FWIW, the mailing list mangles your From: line to work around DMARC issues.
If you could use "git format-patch --force-in-body-from" that would make them
slightly easier to apply.

Regards,
-- 
  Frank Lichtenheld

