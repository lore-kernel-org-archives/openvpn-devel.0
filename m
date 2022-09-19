Date: Mon, 19 Sep 2022 13:41:14 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyhVWmL+ZomdbgX9@...2685...>
References: <20220917233244.13774-1-a@...2181...>
 <20220918220740.32549-1-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220918220740.32549-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] openssl: alternative names support
 for --verify-x509-name CN checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Sep 19, 2022 at 12:07:40AM +0200, Antonio Quartulli wrote:
> From: Mateusz Markowicz <poniekad@...2282...>
> 
> When using "--verify-x509-name [hostname] subject-alt-name" hostname
> will now be accepted also when matched against one of the
> X509v3 Subject Alternative Name IP or DNS entries (instead of just
> Subject's CN).

The code looks like it would do what it says, but the options are then
very confusing, I think.

So if you want to check the name against a SAN of type EMAIL you
need to specify "x509-username-field ext:subjectAltName" but that
will only match against the last SAN. But if you want to check
against a SAN of type DNS or IP you need to specify
"verify-x509-name [hostname] subject-alt-name", which does not
allow the combination with other fields like x509-username-field
but matches against all SANs. Huh?

The design choices that went into the existing x509-username-field
seem questionable in hindsight and don't give a good way of
integrating this functionality. But having two completely separate
implementations of "extract a name from SAN" seems wasteful as well.

Don't have any good solutions to offer atm. Just noting the mess.

Regards,
-- 
  Frank Lichtenheld

