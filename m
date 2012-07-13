Message-ID: <500080B8.3030902@...1147...>
Date: Fri, 13 Jul 2012 22:10:32 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050707060205050609070100"
Subject: [Openvpn-devel] [Fwd: Re: [OpenVPN Community] #97: OpenVPN produces
 DCHP NAK bomb on Win 7 64bit]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN developers <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050707060205050609070100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

did one of the tap-win32 developers see this:

 Seems to be a bug in the TAP driver. It's happening after you try to
 refresh the DHCP lease 3 times (after resume from hibernation, Windows
 tries to acquire a DHCP lease too).
 I think the reason for this is a programming error in dhcp.c in function
 ProcessDHCP:


   // Is this a bad DHCPREQUEST?
   if (msg_type == DHCPREQUEST && dhcp->ciaddr != p_Adapter->m_dhcp_addr)
     ++p_Adapter->m_dhcp_bad_requests;


 should be:

   if (dhcp->ciaddr && msg_type == DHCPREQUEST && dhcp->ciaddr !=
 p_Adapter->m_dhcp_addr)
     ++p_Adapter->m_dhcp_bad_requests;

 as the win32 DHCP client always requests with all fields set to 0, so this
 increases the error counter even though it isn't a bad request and as
 BAD_DHCPREQUEST_NAK_THRESHOLD is 3, it fails after the third renew
 attempt.


?

share and enjoy,

JJK




--------------050707060205050609070100
Content-Type: message/rfc822;
	name="Re: [OpenVPN Community] #97: OpenVPN produces DCHP NAK bomb on
	Win 7 64bit.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="Re: [OpenVPN Community] #97: OpenVPN produces DCHP NAK bomb
	"; filename*1="on Win 7 64bit.eml"

Return-Path: <trac@...1739...>
X-Sieve: CMU Sieve 2.3
X-Virus-Scanned: amavisd-new at nikhef.nl
MIME-Version: 1.0
From: "OpenVPN Trac instance" <trac@...1739...>
X-Trac-Version: 0.11.1
Precedence: bulk
Auto-Submitted: auto-generated
X-Mailer: Trac 0.11.1, by Edgewall Software
X-Trac-Project: OpenVPN Community
Date: Fri, 13 Jul 2012 13:12:31 -0000
Reply-To: trac@...1739...
X-URL: http://openvpn.net
Subject: Re: [OpenVPN Community] #97: OpenVPN produces DCHP NAK bomb on Win
	7 64bit
X-Trac-Ticket-URL: https://community.openvpn.net/openvpn/ticket/97#comment:8
Message-ID: <046.b4f6391e47fc5c9c4125093cb2044427@...1739...>
References: <037.c9851b859e75871e3180d4cfe41fa65d@...1739...>
X-Trac-Ticket-ID: 97
In-Reply-To: <037.c9851b859e75871e3180d4cfe41fa65d@...1739...>
To: undisclosed-recipients:;
X-Bayes-Prob: 0.0001 (Score 0, tokens from: @@RPTN)
X-Spam-Score: 0.00 () [Tag at 5.00] SPF(none:0)
X-CanIt-Geo: ip=208.43.3.116; country=US; region=TX; city=Dallas;
	postalcode=75244; latitude=32.9299; longitude=-96.8353;
	metrocode=623; areacode=972;
	http://maps.google.com/maps?q=32.9299,-96.8353&z=6
X-CanItPRO-Stream: nikhef:janjust@...1147... (inherits from nikhef:default,
	base:default)
X-Canit-Stats-ID: 0VHxNcvuM - 9d9991057c43 - 20120713 (trained as not-spam)
X-Antispam-Training-Forget: https://www.mf.surf.net/canit/b.php?i=0VHxNcvuM&m=9d9991057c43&t=20120713&c=f
X-Antispam-Training-Nonspam: https://www.mf.surf.net/canit/b.php?i=0VHxNcvuM&m=9d9991057c43&t=20120713&c=n
X-Antispam-Training-Spam: https://www.mf.surf.net/canit/b.php?i=0VHxNcvuM&m=9d9991057c43&t=20120713&c=s
X-Scanned-By: CanIt (www . roaringpenguin . com) on 194.171.167.220
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Izk3OiBPcGVuVlBOIHByb2R1Y2VzIERDSFAgTkFLIGJvbWIgb24gV2luIDcgNjRiaXQKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KIFJlcG9ydGVyOiAgamFuanVzdCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICBPd25lcjogICAgICAgICAgICAgICANCiAgICAgVHlwZTogIEJ1ZyAv
IERlZmVjdCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICBTdGF0dXM6ICBjbG9zZWQg
ICAgICAgDQogUHJpb3JpdHk6ICBtYWpvciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgTWlsZXN0b25lOiAgcmVsZWFzZSAyLjIuMg0KQ29tcG9uZW50OiAgTmV0d29ya2luZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgVmVyc2lvbjogIDIuMS40ICAgICAgICAN
CiBTZXZlcml0eTogIE5vdCBzZXQgKGlmIHVuc3VyZSwgc2VsZWN0IHRoaXMgb25lKSAgfCAgIFJl
c29sdXRpb246ICBmaXhlZCAgICAgICAgDQogS2V5d29yZHM6ICB3aW43IHRhcC13aW4zMiBkaGNw
bmFrICAgICAgICAgICAgICAgIHwgIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKQ29tbWVudChieSBl
cnQpOgoKIFNlZW1zIHRvIGJlIGEgYnVnIGluIHRoZSBUQVAgZHJpdmVyLiBJdCdzIGhhcHBlbmlu
ZyBhZnRlciB5b3UgdHJ5IHRvDQogcmVmcmVzaCB0aGUgREhDUCBsZWFzZSAzIHRpbWVzIChhZnRl
ciByZXN1bWUgZnJvbSBoaWJlcm5hdGlvbiwgV2luZG93cw0KIHRyaWVzIHRvIGFjcXVpcmUgYSBE
SENQIGxlYXNlIHRvbykuDQogSSB0aGluayB0aGUgcmVhc29uIGZvciB0aGlzIGlzIGEgcHJvZ3Jh
bW1pbmcgZXJyb3IgaW4gZGhjcC5jIGluIGZ1bmN0aW9uDQogUHJvY2Vzc0RIQ1A6DQoNCg0KICAg
Ly8gSXMgdGhpcyBhIGJhZCBESENQUkVRVUVTVD8NCiAgIGlmIChtc2dfdHlwZSA9PSBESENQUkVR
VUVTVCAmJiBkaGNwLT5jaWFkZHIgIT0gcF9BZGFwdGVyLT5tX2RoY3BfYWRkcikNCiAgICAgKytw
X0FkYXB0ZXItPm1fZGhjcF9iYWRfcmVxdWVzdHM7DQoNCg0KIHNob3VsZCBiZToNCg0KICAgaWYg
KGRoY3AtPmNpYWRkciAmJiBtc2dfdHlwZSA9PSBESENQUkVRVUVTVCAmJiBkaGNwLT5jaWFkZHIg
IT0NCiBwX0FkYXB0ZXItPm1fZGhjcF9hZGRyKQ0KICAgICArK3BfQWRhcHRlci0+bV9kaGNwX2Jh
ZF9yZXF1ZXN0czsNCg0KIGFzIHRoZSB3aW4zMiBESENQIGNsaWVudCBhbHdheXMgcmVxdWVzdHMg
d2l0aCBhbGwgZmllbGRzIHNldCB0byAwLCBzbyB0aGlzDQogaW5jcmVhc2VzIHRoZSBlcnJvciBj
b3VudGVyIGV2ZW4gdGhvdWdoIGl0IGlzbid0IGEgYmFkIHJlcXVlc3QgYW5kIGFzDQogQkFEX0RI
Q1BSRVFVRVNUX05BS19USFJFU0hPTEQgaXMgMywgaXQgZmFpbHMgYWZ0ZXIgdGhlIHRoaXJkIHJl
bmV3DQogYXR0ZW1wdC4NCiBDb3VsZCBzb21lb25lIHBsZWFzZSBmaXggdGhpcyBpbiB0aGUgVEFQ
IGRyaXZlciBhbmQgcHJvdmlkZSBhIHNpZ25lZCBjb3B5Pw0KIFdlIG5lZWQgdGhlIGRyaXZlciBm
b3IgcHJvZHVjdGlvbiB1c2UuLi4NCg0KIFJlZ2FyZHMuCgotLSAKVGlja2V0IFVSTDogPGh0dHBz
Oi8vY29tbXVuaXR5Lm9wZW52cG4ubmV0L29wZW52cG4vdGlja2V0Lzk3I2NvbW1lbnQ6OD4KT3Bl
blZQTiBDb21tdW5pdHkgPGh0dHA6Ly9vcGVudnBuLm5ldD4KT3BlblZQTiBpcyBhIGxheWVyIDIv
MyBTU0wgVlBOCg==

--------------050707060205050609070100--

