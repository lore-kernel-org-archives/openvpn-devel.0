MIME-Version: 1.0
References: <20190613144113.6418-1-arne@...1227...>
In-Reply-To: <20190613144113.6418-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 13 Jun 2019 14:34:23 -0400
Message-ID: <CAKuzo_jUGHTenM_cL_c7+h+703YN7nyXzhYA0r3JDPGyohqfsg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/5] Implement additional two step
 authentication methods
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Thu, Jun 13, 2019 at 10:42 AM Arne Schwabe <arne@...1227...> wrote:
>
> These patches mainly implement forwarding passing/forwarding extra
> messages between management interface on server and client side.
>
> These new extra messages can be used to implement a two step
> authentication like TOTP (Google Authenticator) or web based
> out of band (like SAML).
>
> Since this requires a tight integration on both client and
> server side, it is currently only supported with the management
> interface.
>
> Arne Schwabe (5):
>   Implement parsing and sending INFO and INFO_PRE control messages
>   Implement forwarding client CR_RESPONSE messages to management
>   Implement support for signalling IV_SSO to server
>   Implement sending response to challenge via CR_RESPONSE
>   Implement sending SSO challenge to clients

I haven't looked at the patches, but a quick question. I haven't come across any
2FA mechanisms that cannot be handled (in principle) by the current static an
dynamic CR in OpenVPN. Except that some dynamic CR (e.g, U2F) will require
the possibility to transmit larger messages than currently possible --
especially
the 256 byte limitation in responses from the management as those are
parsed by the config-parser. And possibly the TLS channel buffer size may need
to be increased.

Once those limits are extended, do we need anything more?

You mention google-authenticator OTP but that can perfectly handled as a static
challenge as many do right now.

The current dynamic response implementation is a bad hack -- fail the auth
with challenge embedded in the reason text and then send the response as a
"password" during the next round. So is this about making a cleaner
implementation? Or am I missing something more subtle?

Selva

