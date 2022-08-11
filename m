From: Maximilian Fillinger <maximilian.fillinger@...2507...>
Date: Thu, 11 Aug 2022 12:36:58 +0000
Message-ID: <c86991121a864eec8a06e0670bc20ffc@...2507...>
References: <20220811120722.29168-1-maximilian.fillinger@...2507...>
 <20220811120722.29168-2-maximilian.fillinger@...2507...>
 <1da7a43c-d5d2-69dd-7f07-b412568083d1@...1227...>
In-Reply-To: <1da7a43c-d5d2-69dd-7f07-b412568083d1@...1227...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] Handle EVP_MD_CTX as an opaque
 struct
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5lIFNjaHdhYmUgW21haWx0
bzphcm5lQC4uLjEyMjcuLi5dDQo+IFNlbnQ6IGRvbmRlcmRhZyAxMSBhdWd1c3R1cyAyMDIyIDE0
OjIxDQo+IFRvOiBNYXhpbWlsaWFuIEZpbGxpbmdlciA8bWF4aW1pbGlhbi5maWxsaW5nZXJALi4u
MjUwNy4uLj47IG9wZW52cG4tDQo+IGRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldA0KPiBTdWJq
ZWN0OiBSZTogW09wZW52cG4tZGV2ZWxdIFtQQVRDSCAyLzJdIEhhbmRsZSBFVlBfTURfQ1RYIGFz
IGFuIG9wYXF1ZQ0KPiBzdHJ1Y3QNCj4gDQo+IEFtIDExLjA4LjIyIHVtIDE0OjA3IHNjaHJpZWIg
TWF4IEZpbGxpbmdlcjoNCj4gPiBCdWlsZGluZyBPcGVuVlBOIG9uIHRoZSBsYXRlc3QgT3BlbkJT
RCBzbmFwc2hvdCBmYWlsZWQgYmVjYXVzZQ0KPiBFVlBfTURfQ1RYDQo+ID4gaXMgYW4gb3BhcXVl
IHN0cnVjdCBpbiBMaWJyZVNTTCBub3cuIFRoZXJlZm9yZSwgY2FsbCBtZF9jdHhfbmV3KCkNCj4g
aW5zdGVhZA0KPiA+IG9mIGRlY2xhcmluZyB0aGVtIG9uIHRoZSBzdGFjay4gV2hlbiB0aGV5J3Jl
IG5vdCBvbiB0aGUgc3RhY2sgYW55bW9yZSwNCj4gd2UNCj4gPiBkb24ndCBoYXZlIHRvIGNhbGwg
RVZQX01EX0NUWF9pbml0KCkgYW55bW9yZSwgYnV0IHdlIG5lZWQgdG8gY2FsbA0KPiA+IEVWUF9N
RF9DVFhfZnJlZSgpIGluc3RlYWQgb2YgY2xlYW51cC4NCj4gDQo+IFVyZ2guIFRoZSB3aG9sZSBy
ZWFzb24gSSBsZWZ0IHRoaXMgY29kZSB3aXRoIHRoZSBFVlBfTURfQ1RYIGlzIHRoYXQgaXQNCj4g
aXMgT3BlblNTTCAxLjAuMiBvbmx5IGFuZCBJIGV4cGVjdGVkIHRvIGJlIGFibGUgdG8gcmVtb3Zl
IGl0IHNvb25lciBvcg0KPiBsYXRlci4gU28gTGlicmVTU0wgZG9lZHMgbm90IHN1cHBvcnQgdGhl
IGFsdGVybmF0aXZlIEFQSSBmb3IgdGhhdD8NCj4gDQo+ICAgICAgRVZQX1BLRVlfQ1RYICpwY3R4
ID0gRVZQX1BLRVlfQ1RYX25ld19pZChFVlBfUEtFWV9UTFMxX1BSRiwgTlVMTCk7DQo+IA0KPiBp
cyB3aGF0IHdlIHVzZSBmb3IgT3BlblNTTCAxLjEuMCsNCj4gDQo+IEkgYW0gbm90IGhhcHB5IHRv
IHNvb24gaGF2ZSBMaWJyZVNTTCBzcGVjaWZpYyBjb2RlIGluIG91ciBjb2RlIGJ1dCBpdA0KPiBz
ZWVtcyBsaWtlIGlmIHdhbnQgdG8gY29udGludWUgdGhhdCBsaWJyYXJ5LCB3ZSBoYXZlIHRvLg0K
PiANCj4gVGhlIGNoYW5nZSBsb29rcyBnb29kIGl0c2VsZi4NCj4gDQo+IEFja2VkLUJ5OiBBcm5l
IFNjaHdhYmUgPGFybmVALi4uMTIyNy4uLj4NCg0KTGlicmVTU0wgbm93IGhhcyBFVlBfUEtFWV9D
VFhfbmV3X2lkKCksIGJ1dCBpdCBkb2VzIG5vdCBkZWZpbmUgRVZQX1BLRVlfVExTMV9QUkYuDQo=
