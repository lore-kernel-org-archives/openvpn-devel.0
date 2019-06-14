References: <20190613144113.6418-1-arne@...1227...>
 <CAKuzo_jUGHTenM_cL_c7+h+703YN7nyXzhYA0r3JDPGyohqfsg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a41b35fe-8849-b00b-2213-01d2ec4e8472@...1227...>
Date: Fri, 14 Jun 2019 11:25:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jUGHTenM_cL_c7+h+703YN7nyXzhYA0r3JDPGyohqfsg@...278...>
Content-Language: de-DE
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


> I haven't looked at the patches, but a quick question. I haven't come across any
> 2FA mechanisms that cannot be handled (in principle) by the current static an
> dynamic CR in OpenVPN. Except that some dynamic CR (e.g, U2F) will require
> the possibility to transmit larger messages than currently possible --
> especially
> the 256 byte limitation in responses from the management as those are
> parsed by the config-parser. And possibly the TLS channel buffer size may need
> to be increased.
> 
> Once those limits are extended, do we need anything more?
> 
> You mention google-authenticator OTP but that can perfectly handled as a static
> challenge as many do right now.
> 
> The current dynamic response implementation is a bad hack -- fail the auth
> with challenge embedded in the reason text and then send the response as a
> "password" during the next round. So is this about making a cleaner
> implementation? Or am I missing something more subtle?


Two things basically that play to together making it cleaner and allow
web based authentication to actually not a horrible hack. WEB based SSO
would work as follows:

- Clients connects
- Server get the client auth request.

- Instead of sending success/failed right way, it will send a challenge
   - OPENURL:example.com/logintomyvpn

- Client will continue to wait in this not yet authenticated state

- User will login into the web page, the backend of the web notifies the
VPN server about the result

- VPN will send do client auth succces/failed depending on result

- Client is connected.

Arne


