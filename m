From: James Yonan <jim@...41...>
In-Reply-To: <1112834211.15356.17.camel@...370...>
Message-ID: <Pine.LNX.4.58.0504070022010.22303@...41...>
References: <pan.2005.04.06.20.59.05.1038@...294...> 
 <Pine.LNX.4.58.0504061504500.19198@...41...> <1112834211.15356.17.camel@...370...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-780335898-1112855990=:22303"
Subject: [Openvpn-devel] Re: resolv-retry w/ multiple remote arguments
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr  6 23:40:44 2005
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--8323328-780335898-1112855990=:22303
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 6 Apr 2005, Charles Duffy wrote:

> I'm trying to put together a patch to implement my desired behaviour wrt
> resolv-retry and multiple remote hosts.
> 
> So far, I've made the following changes:
> 
> Setting the default resolv-retry count:
>       * Create a new constant, RESOLV_RETRY_UNSET
>       * Initialize resolve_retry_seconds to RESOLV_RETRY_UNSET rather
>         than RESOLV_RETRY_INFINITE
>       * In options_postprocess(), set resolve_retry_seconds
>         appropriately based on the number of remote hosts provided
> 
> Retrying on DNS failures with resolv-retry 0 and multiple hosts:
>       * Modify resolve_remote() to accept a boolean argument
>         multiple_remotes
>       * In the phase-specific handlers within that same function, treat
>         multiple_remotes as an alternative to resolve_retry_seconds when
>         determining whether GETADDR_FATAL and
>         GETADDR_MENTION_RESOLVE_RETRY should be set (in phase 1) and
>         whether to fail out with an assertion error (in phase 2).
> 
> Thing is, this doesn't actually work: When I run it in a test case in
> with the first remote specified by DNS and the second host specified by
> IP, it tries to resolve the first host in phase 1; fails; tries again in
> phase 2; and fails again (fatally, there, because GETADDR_FATAL is set).
> 
> I presume that it's supposed to loop around to trying phase1 with the
> next host if getaddr fails (on account of using all the available
> retries on the current host) rather than proceeding to phase 2 -- but
> what's the mechanism?

Not really.  phase1 and phase2 are meant to be called only once per
restart.

I would take a different approach (see attached patch).  Rather than
change the defaulting of resolve_retry_seconds, I would just change the
interpretation of RESOLV_RETRY_INFINITE when the remote list > 1 to 
something that makes more sense, i.e. apply the infinite timeout to the 
list as a whole, but resolve each list member with GETADDR_TRY_ONCE.

James
--8323328-780335898-1112855990=:22303
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="openvpn-2.0_rc20RR.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0504070039500.22303@...41...>
Content-Description: 
Content-Disposition: attachment; filename="openvpn-2.0_rc20RR.patch"

ZGlmZiAtdXIgb3BlbnZwbi0yLjBfcmMyMC9zb2NrZXQuYyBvcGVudnBuLTIu
MF9yYzIwUlIvc29ja2V0LmMNCi0tLSBvcGVudnBuLTIuMF9yYzIwL3NvY2tl
dC5jCTIwMDUtMDItMDUgMDE6NDI6MTMuMDAwMDAwMDAwIC0wNzAwDQorKysg
b3BlbnZwbi0yLjBfcmMyMFJSL3NvY2tldC5jCTIwMDUtMDQtMDcgMDA6MDI6
NTYuMzg1NTc4MDQwIC0wNjAwDQpAQCAtOTQsNyArOTQsNyBAQA0KICAgaWYg
KHN0YXR1cyAhPSBPSUFfSVApIC8qIHBhcnNlIGFzIElQIGFkZHJlc3MgZmFp
bGVkPyAqLw0KICAgICB7DQogICAgICAgY29uc3QgaW50IGZhaWxfd2FpdF9p
bnRlcnZhbCA9IDU7IC8qIHNlY29uZHMgKi8NCi0gICAgICBpbnQgcmVzb2x2
ZV9yZXRyaWVzID0gcmVzb2x2ZV9yZXRyeV9zZWNvbmRzIC8gZmFpbF93YWl0
X2ludGVydmFsOw0KKyAgICAgIGludCByZXNvbHZlX3JldHJpZXMgPSAoZmxh
Z3MgJiBHRVRBRERSX1RSWV9PTkNFKSA/IDEgOiAocmVzb2x2ZV9yZXRyeV9z
ZWNvbmRzIC8gZmFpbF93YWl0X2ludGVydmFsKTsNCiAgICAgICBzdHJ1Y3Qg
aG9zdGVudCAqaDsNCiAgICAgICBjb25zdCBjaGFyICpmbXQ7DQogICAgICAg
aW50IGxldmVsID0gMDsNCkBAIC03NjQsNyArNzY0LDE0IEBADQogCSAgICAg
IGludCByZXRyeSA9IDA7DQogCSAgICAgIGJvb2wgc3RhdHVzID0gZmFsc2U7
DQogDQotCSAgICAgIGlmIChwaGFzZSA9PSAxKQ0KKwkgICAgICBpZiAocmVt
b3RlX2xpc3RfbGVuIChzb2NrLT5yZW1vdGVfbGlzdCkgPiAxICYmIHNvY2st
PnJlc29sdmVfcmV0cnlfc2Vjb25kcyA9PSBSRVNPTFZfUkVUUllfSU5GSU5J
VEUpDQorCQl7DQorCQkgIGZsYWdzID0gR0VUQUREUl9SRVNPTFZFOw0KKwkJ
ICBpZiAocGhhc2UgPT0gMikNCisJCSAgICBmbGFncyB8PSAoR0VUQUREUl9U
UllfT05DRSB8IEdFVEFERFJfRkFUQUwpOw0KKwkJICByZXRyeSA9IDA7DQor
CQl9DQorCSAgICAgIGVsc2UgaWYgKHBoYXNlID09IDEpDQogCQl7DQogCQkg
IGlmIChzb2NrLT5yZXNvbHZlX3JldHJ5X3NlY29uZHMpDQogCQkgICAgew0K
ZGlmZiAtdXIgb3BlbnZwbi0yLjBfcmMyMC9zb2NrZXQuaCBvcGVudnBuLTIu
MF9yYzIwUlIvc29ja2V0LmgNCi0tLSBvcGVudnBuLTIuMF9yYzIwL3NvY2tl
dC5oCTIwMDUtMDItMDUgMDE6MzY6MzEuMDAwMDAwMDAwIC0wNzAwDQorKysg
b3BlbnZwbi0yLjBfcmMyMFJSL3NvY2tldC5oCTIwMDUtMDQtMDYgMjM6MTg6
MzkuMzg1NTAzNDQ4IC0wNjAwDQpAQCAtMzYzLDYgKzM2Myw3IEBADQogI2Rl
ZmluZSBHRVRBRERSX0ZBVEFMX09OX1NJR05BTCAgICAgICAoMTw8NCkNCiAj
ZGVmaW5lIEdFVEFERFJfV0FSTl9PTl9TSUdOQUwgICAgICAgICgxPDw1KQ0K
ICNkZWZpbmUgR0VUQUREUl9NU0dfVklSVF9PVVQgICAgICAgICAgKDE8PDYp
DQorI2RlZmluZSBHRVRBRERSX1RSWV9PTkNFICAgICAgICAgICAgICAoMTw8
NykNCiANCiBpbl9hZGRyX3QgZ2V0YWRkciAodW5zaWduZWQgaW50IGZsYWdz
LA0KIAkJICAgY29uc3QgY2hhciAqaG9zdG5hbWUsDQo=

--8323328-780335898-1112855990=:22303--

