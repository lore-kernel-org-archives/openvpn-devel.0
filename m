Date: Wed, 14 Dec 2022 16:25:00 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y5nqzKAt5o4AzHVq@...2685...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <afaffee7-1c3a-79ad-9eca-ec7e3e5941b9@...2704...>
 <20221211190913.190-1-marc.becker@...2704...>
MIME-Version: 1.0
In-Reply-To: <20221211190913.190-1-marc.becker@...2704...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] unify code path for adding
 PKCS#11 providers
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
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Dec 11, 2022 at 08:09:13PM +0100, Marc Becker via Openvpn-devel wrote:
> Use existing wrapper for pkcs11h_addProvider to have arguments with
> "magic values" for pkcs11-helper call in a central place.
> 
> Slot event argument to pkcs11h_addProvider has NOT been a boolean for
> at least 15 years.
> Luckily the default is PKCS11H_SLOTEVENT_METHOD_AUTO=0=FALSE.

Change makes sense and should not change behavior AFAICT.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

