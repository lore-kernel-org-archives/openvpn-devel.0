MIME-Version: 1.0
In-Reply-To: <CAEsd45Q+4GYFhf1Jmn-UrPVKFHoGsE3NP9oq13mh8_p1wqxLog@...278...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
 <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
 <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
 <f06320ac-5b89-0cdd-9ef1-eddde02b848a@...2080...>
 <CAKuzo_gpcR9PrVcPWYRsa7v7sATsbj=2hQYNzaJ-hpjjk7ZeAw@...278...>
 <CAEsd45Q+4GYFhf1Jmn-UrPVKFHoGsE3NP9oq13mh8_p1wqxLog@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 25 Jan 2018 13:36:20 -0500
Message-ID: <CAEsd45QqwxqTfWrhfD3i7VScTzQiEDeFJrbk9Nky05THGMnrcQ@...278...>
Subject: [Openvpn-devel] Fwd: [PATCH 2/3] Allow external EC key through
 --management-external-key
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
To: openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>

Hi.

On Mon, Jan 22, 2018 at 12:31 PM, Selva Nair <selva.nair@...277...> wrote:
> What about extending the current "version" command with an argument
> where the client states the version of "management-speak" that it
> supports. Current management version is 1, we increase it to 1.1 and
> unless the client says "version 1.1" or more we do not send PK_SIGN.
> The client could do that when it gets the version message or any time
> later. The response to version command (current management version and
> openvpn daemon's version stays the same). No full-fledged cap
> negotiation, but good enough.

That sounds reasonable; easy to implement in Tunnelblick


> The UX would be much better that way.

Absolutely.

Best regards,

Jon Bullard

