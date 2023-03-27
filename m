Date: Mon, 27 Mar 2023 10:49:52 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZCFYsIhSsTdQDDk8@...2685...>
References: <20230323143140.76949-1-frank@...2641...>
 <CAKuzo_i+EEaThhmtOHjJGwprtnRgQGxDSNMpeJ+aHHH1FPGNOw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i+EEaThhmtOHjJGwprtnRgQGxDSNMpeJ+aHHH1FPGNOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Mar 24, 2023 at 01:13:22PM -0400, Selva Nair wrote:
> Would the attached small patch be acceptable instead? It covers only
> test_cryptoapi --- if this will do, I can incorporate similar changes for
> test_pkcs11 into a v2 of the relevant patch as those have not been
> ACK-ed yet.

Actually, I acked that whole series. However there was a problem with
my mail configuration on that day and so Gmail rejected them. They
are on the list however.

But feel free to integrate this and I can re-ack the patch.

Regards,
-- 
  Frank Lichtenheld

