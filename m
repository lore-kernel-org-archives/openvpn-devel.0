MIME-Version: 1.0
In-Reply-To: <1474538677-23301-1-git-send-email-davids@...515...>
References: <1474538677-23301-1-git-send-email-davids@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 22 Sep 2016 07:38:49 -0400
Message-ID: <CAEsd45RURXK2Q=EGZ-QMtUfPmRC=i5FE4yazarcgW_uj3gmbsA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Sep 22, 2016 at 6:04 AM, David Sommerseth <davids@...515...> wrote:
> If running an OpenVPN client with --enable-pkcs11 and a server without
> and having a username and/or password with more than 128 characters,
> the authentication will fail as the server truncates the password
> to 128 bytes.
>
> This makes things easier and more predictable.  Username/passwords
> can be up to 4096 bytes, regardless of the --enable-pkcs11 state.

Hi David,

1. Minor quibble: "Characters" is a bit misleading because (I think)
it is actually the number of bytes that is limited -- a UTF-8 string
of 256 bytes may represent fewer than 256 characters.

2. The management interface limits usernames, passwords, and private
keys to 255 or 256 bytes. The following error is sent by over the
management interface in response to a 275 byte password ("a-y"
repeated 11 times):

ERROR: Options error: Parameter at TCP:0 is too long (256 chars max):
abcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcde

Note that although the error message says 256 characters is the
maximum, there are only 255 characters/bytes in the password it sends
back. Perhaps an off-by-one error? (And I am pretty sure that "bytes"
is what is limited, not "characters", as per above.)

Best regards,

Jon Bullard

