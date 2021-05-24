MIME-Version: 1.0
References: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
In-Reply-To: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 May 2021 13:39:21 -0400
Message-ID: <CAKuzo_heOferug+BNyGaKc66_pD2AQO72PSAioGH+aTXux3jsQ@...278...>
Subject: Re: [Openvpn-devel] --tls-verify runs twice for a single cert in
 Peer-fingerprint mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, May 24, 2021 at 10:09 AM tincantech via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi,
>
> Is this expected ?
>
> Server log:
>
> 2021-05-24 14:58:03 us=534606 10.10.201.226:60276 TLS CRYPT V2 VERIFY SCRIPT OK
> 2021-05-24 14:58:03 us=558066 10.10.201.226:60276 VERIFY KU OK
> 2021-05-24 14:58:03 us=558105 10.10.201.226:60276 Validating certificate extended key usage
> 2021-05-24 14:58:03 us=558120 10.10.201.226:60276 ++ Certificate has EKU (str) TLS Web Client Authentication, expects TLS Web Client Authentication
> 2021-05-24 14:58:03 us=558130 10.10.201.226:60276 VERIFY EKU OK
> <EXOK> * EasyTLS-verify => CN: cli-arch-v21x connection allowed
> 2021-05-24 14:58:03 us=573751 10.10.201.226:60276 VERIFY SCRIPT OK: depth=0, CN=cli-arch-v21x
> 2021-05-24 14:58:03 us=573782 10.10.201.226:60276 VERIFY OK: depth=0, CN=cli-arch-v21x
> 2021-05-24 14:58:03 us=573911 10.10.201.226:60276 VERIFY KU OK
> 2021-05-24 14:58:03 us=573928 10.10.201.226:60276 Validating certificate extended key usage
> 2021-05-24 14:58:03 us=573939 10.10.201.226:60276 ++ Certificate has EKU (str) TLS Web Client Authentication, expects TLS Web Client Authentication
> 2021-05-24 14:58:03 us=573948 10.10.201.226:60276 VERIFY EKU OK
> <EXOK> * EasyTLS-verify => CN: cli-arch-v21x connection allowed
> 2021-05-24 14:58:03 us=588472 10.10.201.226:60276 VERIFY SCRIPT OK: depth=0, CN=cli-arch-v21x
> 2021-05-24 14:58:03 us=588508 10.10.201.226:60276 VERIFY OK: depth=0, CN=cli-arch-v21x
> 2021-05-24 14:58:03 us=590929 10.10.201.226:60276 peer info: IV_VER=2.6_git

This looks like an unintended consequence of how and when OpenSSL
executes the verify callback. If there are no verification errors, the
callback is called only once for each depth with preverify_ok = 1.
When there are errors (as is the case when CA is missing), for each
depth and each error we get a callback. (Ref: OpenSSL docs on
SSL_CTX_set_verify).

Even for self-signed certs one would get a call with an error saying
certificate is self-signed and then possibly another call with
signature verification success. For a cert issued by a CA, one would
first get an "issuer missing" error followed by a "signature
verification" error and no success calls unless there are intermediate
certs.

This was not an issue before fingerprint support. In that case we do
not proceed further when OpenSSL reports a verify error.

The easiest option for scripts may be to be prepared to be called
mutiple times with the same cert and same depth. I think we should
export the verification error-status to the env so that the script
could make a more informed decision.

Our internal callback is not meant to be executed multiple times with
same depth, but the side effects appear to be benign -- like repeated
VERIFY OK in the logs.

Selva

