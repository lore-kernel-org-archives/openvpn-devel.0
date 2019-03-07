References: <20190218153129.3818-1-bengen@...2496...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <09cfba8a-d023-c294-9338-8cc664b835a0@...2080...>
Date: Thu, 7 Mar 2019 20:14:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190218153129.3818-1-bengen@...2496...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Do not set pkcs11-helper "safe fork
 mode"
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
To: Hilko Bengen <bengen@...2496...>, openvpn-devel@lists.sourceforge.net

On 18/02/2019 16:31, Hilko Bengen wrote:
> From the pkcs11-helper API documentation about pkcs11h_setForkMode():
> 
>> This funciton is releavant if PKCS11H_FEATURE_MASK_THREADING is
>> set. If safe mode is on, the child process can use the loaded
>> PKCS#11 providers but it cannot use fork(), while it is in one of
>> the hooks functions, since locked mutexes cannot be released.
> 
> As far as I can tell, pkcs11-helper functionality is not used in a
> child process that is created after initialization. Even if OpenVPN is
> turned into a daemon, the pkcs11-helper library is only initialized
> after calling possibly_become_daemon(), i.e. in the child process. All
> other uses of fork() are immediately followed by an exec()
> 
> This simple change fixes the symptoms described in both
> <https://community.openvpn.net/openvpn/ticket/538> (hang on password
> prompt when systemd support is enabled) and
> <https://community.openvpn.net/openvpn/ticket/1157> (hang on
> initialization with newer versions of pkcs11-helper).
> 
> I have successfully tested that this makes the described symptoms go
> away. For this, I used a YubiKey NEO on Debian/stable, a rebuild of
> OpenVPN 2.4.6 and two versions of libpkcs11-helper:
> 
> - libpkcs11-helper 1.21-1 from Debian/stretch
> - a backport of libpkcs11-helper 1.25-1 from Debian/buster

Hi,

Sorry for the time it has take to have a look at this.  I've spent time trying
to understand how the pkcs11-helper handles things ... and how the whole
forking stuff happens.  And this approach does look promising.

But ... it doesn't really work on my RHEL 7.6 system (using
pkcs11-helper-1.11-3.el7.x86_64).  I've tested this with a yubikey 4 token,
with a RSA-2048 key.

The relevant log lines:
----------------------------------------------------------------------------
Thu Mar  7 19:37:54 2019 us=108092 VERIFY OK: depth=0, CN=devtest.example.org
Enter test.user token Password: ******
Thu Mar  7 19:37:56 2019 us=5368 PKCS#11: Cannot perform signature
179:'CKR_SESSION_HANDLE_INVALID'
Thu Mar  7 19:37:56 2019 us=5429 OpenSSL: error:14099006:SSL
routines:ssl3_send_client_verify:EVP lib
Thu Mar  7 19:37:56 2019 us=5438 TLS_ERROR: BIO read tls_read_plaintext error
Thu Mar  7 19:37:56 2019 us=5448 TLS Error: TLS object -> incoming plaintext
read error
Thu Mar  7 19:37:56 2019 us=5454 TLS Error: TLS handshake failed
Thu Mar  7 19:37:56 2019 us=5601 TCP/UDP: Closing socket
----------------------------------------------------------------------------

When I compile *without* --enable-systemd, this works.  Which is odd.  I've
checked that the input provided is identical.  Both builds with and without
systemd support ends up with the same "pin" value.  But for some reason the
systemd build fails when calling pkcs11h_openssl_session_getEVP() in
pkcs11_init_tls_session() [pkcs11_openssl.c:65].

Based on the error message (CKR_SESSION_HANDLE_INVALID), it seems the locking
being disabled with using pkcs11h_setForkMode(FALSE) still breaks something
along the way.

On the positive side, the "hang" we experience without this patch is gone.
But I can't claim this being a proper fix as it is currently :-/


-- 
kind regards,

David Sommerseth
OpenVPN Inc


