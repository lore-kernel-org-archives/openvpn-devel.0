Date: Thu, 23 Mar 2023 09:49:47 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZBwSq8rEwiOq7+HF@...2685...>
References: <20230322221456.1660425-1-selva.nair@...277...>
 <20230322221456.1660425-2-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230322221456.1660425-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Unit tests: Test for PKCS#11 using
 a softhsm2 token
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 22, 2023 at 06:14:55PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Load some test certificate/key pairs into a temporary softhsm2 token
>   and enumerate available objects through pkcs11-helper interface
> 
> - For each object, load it into SSL_CTX and test sign (if using OpenSSL 3)
>   or check the certificate and public-key match (if using OpenSSl 1.1.1.).
>   The pkcs11-id for each object is specified directly or
>   through a mocked management callback to test pkcs11-id-management
> 
> Limitations:
>   Depends on libsofthsm2.so and p11tool (install softhsm2 and gnutls-bin
>   packages). Mbed-TLS/pkcs11-helper combination is not tested.
> 
>   If locations of these binaries are not auto-detected or need to be
>   overridden, use -DSOFTHSM2_UTIL=<path> -DP11TOOL=<path> to configure.
>   Location of SOFTHSM2_MODULE is not auto-detected and defaults to
>   /usr/lib/softhsm/libsofthsm2.so. It may be changed by passing
>   -DSOFTHSM2_MODULE=/some-path/libsofthsm2.so to configure.
>   Also see "configure --help".
> 
>   The test is enabled only if --enable-pkcs11 is in use, and SOFTHSM2_UTIL
>   & P11TOOL are found in path or manually defined during configuring.
> 
> Changes relative to github PR
>   - Explicitly disable building the test on Windows: need to port mkstemp,
>     mkdtemp, setenv etc., before enabling this on Windows.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>

I reviewed this on Github, with a focus on the configuration part.

Approved it there, so
Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

