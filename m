MIME-Version: 1.0
Date: Fri, 2 Sep 2011 11:56:49 -0600
Message-ID: <CAM9ceLhjdNimfwMEb3z-Ue4ioqvNp67KeWa8pVTqNc25ZiKq-g@...278...>
From: Jeff Sadowski <jeff.sadowski@...277...>
Content-Type: multipart/mixed; boundary=001485f1e26ee3c7a404abf915ef
Subject: [Openvpn-devel] script to rename a network node.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001485f1e26ee3c7a404abf915ef
Content-Type: text/plain; charset=ISO-8859-1

I was looking for a scripted way to rename the tap network node to
make it easier for installing my clients.
Attached is the batch file I used to rename my network node. I still
have to answer yes to two questions but that is much easier to
instruct someone to do.
This was tested on Windows 7 it should work on older versions of
windows (with XP it should work even better) but I haven't tried it
yet.
Basically what this script does is as follows
it dumps the content of
HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}
and looks for the "TAP-Win32 Adapter V9" DriverDesc and matches it up
with its NetCfgInstanceId
It then creates a reg file that modifies the
HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}\[NetCfgInstanceId]\Connection\Name
registry entry to the name you have in the client.ovpn config file.

Could Microsoft have picked a more obscure naming convention?

--001485f1e26ee3c7a404abf915ef
Content-Type: text/plain; charset=US-ASCII; name="network_devices.txt"
Content-Disposition: attachment; filename="network_devices.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gs3gdsxm0

QGVjaG8gb2ZmDQpzZXRsb2NhbCBFbmFibGVEZWxheWVkRXhwYW5zaW9uDQpzZXQgIm5ldHdvcmtm
aWxlPSVIT01FRFJJVkUlJUhPTUVQQVRIJVxuZXR3b3Jrcy5yZWciDQpzZXQgImRyaXZlcnNmaWxl
PSVIT01FRFJJVkUlJUhPTUVQQVRIJVxub2Rlcy50eHQiDQpzZXQgIm9wZW52cG5jZmc9JVByb2dy
YW1GaWxlcyVcT3BlblZQTlxjb25maWdcY2xpZW50Lm92cG4iDQoNCnJlZ2VkaXQuZXhlIC9lICIl
bmV0d29ya2ZpbGUlIiBIS0VZX0xPQ0FMX01BQ0hJTkVcU1lTVEVNXENvbnRyb2xTZXQwMDFcQ29u
dHJvbFxDbGFzc1x7NEQzNkU5NzItRTMyNS0xMUNFLUJGQzEtMDgwMDJCRTEwMzE4fQ0KdHlwZSAi
JW5ldHdvcmtmaWxlJSIgfCBmaW5kc3RyICJOZXRDZmdJbnN0YW5jZUlkIERyaXZlckRlc2MiID4g
IiVkcml2ZXJzZmlsZSUiDQpkZWwgIiVuZXR3b3JrZmlsZSUiDQoNCnNldCAibm9kZT0iDQpGT1Ig
L0YgInRva2Vucz0xLDIgZGVsaW1zPT0iICUlQSBJTiAoJ3R5cGUgIiVkcml2ZXJzZmlsZSUiJykg
RE8gKA0KIHNldCAibGFzdG5vZGU9IW5vZGUhIg0KIHNldCAibm9kZT0lJUIiDQogc2V0ICJ0ZXN0
PSUlQSINCiBpZiBbIXRlc3QhXSA9PSBbIkRyaXZlckRlc2MiXSAoDQogIGlmIFshbm9kZSFdID09
IFsiVEFQLVdpbjMyIEFkYXB0ZXIgVjkiXSAoDQogICBzZXQgIlRBUElOVEVSRkFDRT0hbGFzdG5v
ZGU6fjEsLTEhIg0KICApDQogKQ0KKQ0KdHlwZSAiJW9wZW52cG5jZmclIiB8IGZpbmRzdHIgZGV2
LW5vZGUgPiAiJWRyaXZlcnNmaWxlJSINCkZPUiAvRiAidG9rZW5zPTEsMiIgJSVBIElOICgndHlw
ZSAiJWRyaXZlcnNmaWxlJSInKSBETyAoDQppZiBbJSVBXSA9PSBbZGV2LW5vZGVdICgNCnNldCAi
bm9kZW5hbWU9JSVCIg0KKQ0KKQ0KZGVsICIlZHJpdmVyc2ZpbGUlIg0KDQplY2hvIFdpbmRvd3Mg
UmVnaXN0cnkgRWRpdG9yIFZlcnNpb24gNS4wMCA+ICIlbmV0d29ya2ZpbGUlIg0KZWNoby4gPj4g
IiVuZXR3b3JrZmlsZSUiDQplY2hvIFtIS0VZX0xPQ0FMX01BQ0hJTkVcU1lTVEVNXENvbnRyb2xT
ZXQwMDFcQ29udHJvbFxOZXR3b3JrXHs0RDM2RTk3Mi1FMzI1LTExQ0UtQkZDMS0wODAwMkJFMTAz
MTh9XCVUQVBJTlRFUkZBQ0UlXENvbm5lY3Rpb25dID4+ICIlbmV0d29ya2ZpbGUlIg0KZWNobyAi
TmFtZSI9IiVub2RlbmFtZSUiID4+ICIlbmV0d29ya2ZpbGUlIg0KDQpyZWdlZGl0LmV4ZSAvcyAi
JW5ldHdvcmtmaWxlJSINCmRlbCAiJW5ldHdvcmtmaWxlJSI=
--001485f1e26ee3c7a404abf915ef--

