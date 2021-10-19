References: <20211019034118.28987-1-selva.nair@...277...>
 <20211019034118.28987-2-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <11ff0dad-e26e-358b-11d5-ecf855e29f4c@...1227...>
Date: Tue, 19 Oct 2021 12:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <20211019034118.28987-2-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove error injection into OpenSSL
 from cryptoapi.c
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
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 19.10.21 um 05:41 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> There is no advantage in injecting/redirecting errors into OpenSSL
> as we can, and we do, report these directly using our own logging
> functions. This code probably originated from CAPI engine where
> such usage made sense.
> 
> And, in cases when the error is within OpenSSL, guessing a
> reason (like out of memory) and inserting it into the
> OpenSSL error stack looks pointless.
> 
> As a bonus, the code gets leaner and a lot less cruft.
> 
> Some error messages are slightly edited and all near-fatal
> errors are logged with M_NONFATAL and "Error in cryptoapicert:"
> prefix.
> 
> Also remove some defines for mingw that we do not need.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>


Acked-By: Arne Schwabe <arne@...1227...>

Arne




