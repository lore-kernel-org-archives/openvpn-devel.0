Date: Wed, 24 Aug 2022 13:38:11 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwYNozA52gnEVLUA@...2685...>
References: <20220824093723.64618-1-arne@...1227...>
 <20220824104607.70531-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220824104607.70531-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Improve data key id not found error
 message
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
To: openvpn-devel@lists.sourceforge.net

On Wed, Aug 24, 2022 at 12:46:07PM +0200, Arne Schwabe wrote:
> With delayed data key generation now with deferred auth, NCP and similar
> mechanism the "TLS Error: local/remote TLS keys are out of sync" is shown
> much too frequent and confuses a lot of people.
> 
> This also removes the dead code of printing multi not ready keys and
> replace it with an assert.
> 
> Factor out printing of error messages into an extra function to make
> the code easier to understand and also to only call into that function
> in the case that a key is not found and avoid the overhead.
> 
> Patch v2: fix comparing key_id to state value, improve message

Okay, less confusing. But I still don't understand why we loop over all keys
without checking the ks->key_id?

Regards,
-- 
  Frank Lichtenheld

