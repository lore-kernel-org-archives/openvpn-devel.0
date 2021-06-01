References: <20210524184506.20582-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <154d4857-f994-33aa-ca3e-f18cc33d5eb4@...1227...>
Date: Tue, 1 Jun 2021 14:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210524184506.20582-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Do not require CA when peer-fingerprint
 is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 24.05.21 um 20:45 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Fix --ca or --ca-path check when --pkcs11-id or --cryptoapicert
> is used with --peer-fingerprint.
> 
> The multiple --ca or --capath checks are consolidated into a function
> 

Yes that change makes sense.

Acked-By: Arne Schwabe <arne@...1227...>

