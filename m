References: <20210922211254.7570-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ed918ec7-2301-0e66-4bbe-f9141c97b406@...1227...>
Date: Thu, 23 Sep 2021 13:11:35 +0200
MIME-Version: 1.0
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 22.09.21 um 23:12 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> The following series of patches implement a built-in
> provider for interfacing OpenSSL 3.0 when external 
> keys are in use.
> 
> Essentially, to intercept the sign operation, the SSL_CTX
> object has to be created with properties string set to 
> prioritize our provider. In the provider we implement
> only keymgmt and signature operations and specify the
> property string as optional. That allows all operations
> we do not provide to be used from the default provider.
> 
> This patch set stops at interfacing the provider with
> management-external-key. For pkcs11-helper, only some glue
> code is needed and is in the works. Same with cryptoapicert
>  aka CNG, but I want to cleanup the old code a bit before
> hooking to the provider.
> 
> I haven't attempted to remove any of the deprecated interfaces.
> That is better done along with Arne's patches. There will be
> only minor, if at all any, conflicts between that and this 
> patch set. 
>

Great work and also extremely quick on the implementation. This
currently puts myself in a bit of dilemma. We (=OpenVPN Inc) need a
similar/same implementation in OpenVPN3 too. I think after I do the
review I am probably too biased to finish my own implementation without
running into the problem of it being derivative.

Your code is currently GPL2 only and not BSD like or you explicitly
agreeing to have it under the CLA of openvpn3 library. This is
completely fine. I am not arguing it should be different.

So I have two options here:

a) I finish my own implementation of the provider for OpenVPN3 to not be
influenced by this implementation and review this implementation after that

b) you agree that I can take parts of your code for the OpenVPN3
implementation, then I go directly into review and then base my OpenVPN3
implementation on your xkey provider implementation.

Arne

