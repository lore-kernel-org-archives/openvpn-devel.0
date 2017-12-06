From: Simon Rozman <simon@...2293...>
Date: Wed, 6 Dec 2017 17:10:45 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
 <20171204192515.GA69387@...1296...>
 <99D61A626FDA8A4B90A270669121BE1085B4AC9A@...2294...>
 <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
In-Reply-To: <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

SGksDQoNCj4gPiBUaGUgZ2V0X2ludGVyZmFjZV9tZXRyaWMoKSBmdW5jdGlvbiBzaG91bGQgZ2V0
IGEgbW9yZSB0aG9yb3VnaCByZXdyaXRlDQo+IHRoYW4ganVzdCBhIGNvbXBpbGVyIHdhcm5pbmcg
c2h1dC11cC4gU28gdGhlIHBhdGNoIHdpbGwgcHJvYmFibHkgZ2V0IGRpdmlkZWQNCj4gaW4gdHdv
IC0gdGhlIHNpbXBsZSBzaWduZWQvdW5zaWduZWQgZml4ZXMgYW5kIGdldF9pbnRlcmZhY2VfbWV0
cmljKCkNCj4gcmVkZXNpZ24uDQo+IA0KPiBGb3IgdGhlIGxhdHRlciwgSSBoYWQgInJlLWludmVu
dGVkIiB0aGUgZ2V0X2ludGVyZmFjZV9tZXRyaWMgZnVuY3Rpb24gZm9yIHRoZQ0KPiBwZW5kaW5n
ICJ1c2UgbG93ZXN0IG1ldHJpYyBpbnRlcmZhY2Ugd2hlbiBtdWx0aXBsZSBpbnRlcmZhY2VzIG1h
dGNoIGENCj4gcm91dGUiIHBhdGNoLg0KPiANCj4gT2J2aW91c2x5LCBpdHMgYmV0dGVyIHRvIHJl
ZmFjdG9yIHRoaXMgb25lIGFuZCB1c2UgaXQgdGhlcmUsIHNvIEkganVzdCBjb3BpZWQgdGhlDQo+
IGltcGxlbWVudGF0aW9uIGFuZCBzdWJtaXR0ZWQgYSBwYXRjaCB0byBkbyBzby4gVW5saWtlIEkg
aGFkIHRob3VnaHQgZWFybGllciwNCj4gdGhpcyBoYXMgdG8gc3RheSBpbiBibG9ja19kbnMuaCBm
b3IgZWFzZSBvZiBzaGFyaW5nIHdpdGggdGhlIHNlcnZpY2UuDQo+IA0KPiBDb3VsZCB5b3UgcGxl
YXNlIHRha2UgYSBsb29rIGFuZCBzZWUgd2hldGhlciBpdCBhZGRyZXNzZXMgTVNWQydzIGNvbmNl
cm5zDQo+IGFtb25nIG90aGVyIHRoaW5ncz8NCg0KSSBoYXZlIHRlc3RlZCBhbmQgYW0gY29uZmly
bWluZyBNU1ZDIGlzIGhhcHB5IHdpdGggdGhlIGJsb2NrX2Rucy5jIG5vdy4NCg0KU2hvdWxkIHlv
dXIgcGF0Y2ggYmUgbWVyZ2VkLCBJIHNoYWxsIHJlYmFzZSB0aGUgIltQQVRDSCAwOS8xM10gU2ln
bmVkL3Vuc2lnbmVkIHdhcm5pbmdzIG9mIE1TVkMgcmVzb2x2ZWQiIHRvIHRoZSBuZXcgbWFzdGVy
IGFuZCBkZWxpdmVyIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNClNpbW9uDQo=
