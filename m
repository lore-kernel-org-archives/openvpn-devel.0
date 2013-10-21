MIME-Version: 1.0
From: Nicholas Hall <ngharo@...277...>
Date: Mon, 21 Oct 2013 13:05:21 -0500
Message-ID: <CAK6ywbLqTT8bkfF54qCt34HrOtueE8WdKacwSwu--nZCtcRXoA@...278...>
Content-Type: multipart/mixed; boundary=001a11c30350d2134204e9442195
Subject: [Openvpn-devel] [PATCH] Properly quote command and arguments passed
	to system() in down-root
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a11c30350d2134204e9442195
Content-Type: multipart/alternative; boundary=001a11c30350d2133e04e9442193

--001a11c30350d2133e04e9442193
Content-Type: text/plain; charset=ISO-8859-1

Via GitHub Pull Request
https://github.com/OpenVPN/openvpn/pull/9

Attached patch file for convenience
------------------------------------------------------


Suppose the following command:
openvpn --config config \
--plugin /usr/lib/openvpn/openvpn-plugin-down-root.so "bash -c
\"script_type=down cmd\""

One might suspect that this would eventually call execve with an array
like: ["bash", "-c", "script_type=down cmd"]. However the array passed
would currently be: ["bash", "-c", "script_type=down", "cmd"]

What happens is the plugin argument processing will (eventually) pass
bash -c "script_type=down cmd" to parse_line, which will parse the
string to an array as ["bash", "-c", "script_type=down cmd"] and pass it
as the argv parameter to down-root's openvpn_plugin_open_v1. So far so
good.

Then down-root flattens out the array to a single string by joining the
elements with a space using build_command_line. So then we get bash -c
script_type=down cmd. This will be fed as the argument to system(),
which internally runs sh -c 'bash -c script_type=down cmd'. So bash
would then run the command script_type=down with the first argument of
its argument array being cmd, not what we had wanted.

The problem is down-root plugin's build_command_line assumes that no
quoting of arguments needs to be done. The current implementation can be
hacked around to get the semantics we want here, however providing the
right escaping requires either luck or knowledge of how down-root is
implemented.

This pull request fixes this by assuming that all elements of the array
passed to build_command_line require quoting. If no quoting is required,
extra quoting will essentially be ignored.

Perhaps a better solution would be to use execvp/execvpe, instead of
flattening the the args to a string, only then have them parsed back
into arrays. That would be a more invasive change though, and I don't
know if there are any cross-platform issues there.

This patch will make a backwards incompatible change for those have
hacked around this issue to get it to work. I would suspect that to be
few.
---
 src/plugins/down-root/down-root.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/plugins/down-root/down-root.c
b/src/plugins/down-root/down-root.c
index d51d0e5..9594e4c 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -233,7 +233,7 @@ build_command_line (const char *argv[])
     {
       for (i = 0; argv[i]; ++i)
  {
-   size += (strlen (argv[i]) + 1); /* string length plus trailing space */
+   size += (strlen (argv[i]) + 3); /* string length plus quotes and
trailing space */
    ++n;
  }
     }
@@ -251,7 +251,9 @@ build_command_line (const char *argv[])
   /* build string */
   for (i = 0; i < n; ++i)
     {
+      strcat (string, "\"");
       strcat (string, argv[i]);
+      strcat (string, "\"");
       if (i + 1 < n)
  strcat (string, " ");
     }
@@ -455,7 +457,6 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 static void
 down_root_server (const int fd, char *command, const char *argv[], const
char *envp[], const int verb)
 {
-  const char *p[3];
   char *command_line = NULL;
   char *argv_cat = NULL;
   int i;
@@ -482,10 +483,12 @@ down_root_server (const int fd, char *command, const
char *argv[], const char *e
     argv_cat = build_command_line (&argv[1]);
   else
     argv_cat = build_command_line (NULL);
-  p[0] = command;
-  p[1] = argv_cat;
-  p[2] = NULL;
-  command_line = build_command_line (p);
+
+  command_line = (char *) malloc (strlen(command) + strlen(argv_cat) + 2);
+  *command_line = '\0';
+  strcat(command_line, command);
+  strcat(command_line, " ");
+  strcat(command_line, argv_cat);

   /*
    * Save envp in environment
--
1.7.10.4

--001a11c30350d2133e04e9442193
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Via GitHub Pull Request<div><a href=3D"https://github.com/=
OpenVPN/openvpn/pull/9">https://github.com/OpenVPN/openvpn/pull/9</a><br></=
div><div><br></div><div>Attached patch file for convenience</div><div>-----=
-------------------------------------------------</div>

<div><br></div><div><br></div><div><div>Suppose the following command:</div=
><div>openvpn --config config \</div><div>--plugin /usr/lib/openvpn/openvpn=
-plugin-down-root.so &quot;bash -c</div><div>\&quot;script_type=3Ddown cmd\=
&quot;&quot;</div>

<div><br></div><div>One might suspect that this would eventually call execv=
e with an array</div><div>like: [&quot;bash&quot;, &quot;-c&quot;, &quot;sc=
ript_type=3Ddown cmd&quot;]. However the array passed</div><div>would curre=
ntly be: [&quot;bash&quot;, &quot;-c&quot;, &quot;script_type=3Ddown&quot;,=
 &quot;cmd&quot;]</div>

<div><br></div><div>What happens is the plugin argument processing will (ev=
entually) pass</div><div>bash -c &quot;script_type=3Ddown cmd&quot; to pars=
e_line, which will parse the</div><div>string to an array as [&quot;bash&qu=
ot;, &quot;-c&quot;, &quot;script_type=3Ddown cmd&quot;] and pass it</div>

<div>as the argv parameter to down-root&#39;s openvpn_plugin_open_v1. So fa=
r so</div><div>good.</div><div><br></div><div>Then down-root flattens out t=
he array to a single string by joining the</div><div>elements with a space =
using build_command_line. So then we get bash -c</div>

<div>script_type=3Ddown cmd. This will be fed as the argument to system(),<=
/div><div>which internally runs sh -c &#39;bash -c script_type=3Ddown cmd&#=
39;. So bash</div><div>would then run the command script_type=3Ddown with t=
he first argument of</div>

<div>its argument array being cmd, not what we had wanted.</div><div><br></=
div><div>The problem is down-root plugin&#39;s build_command_line assumes t=
hat no</div><div>quoting of arguments needs to be done. The current impleme=
ntation can be</div>

<div>hacked around to get the semantics we want here, however providing the=
</div><div>right escaping requires either luck or knowledge of how down-roo=
t is</div><div>implemented.</div><div><br></div><div>This pull request fixe=
s this by assuming that all elements of the array</div>

<div>passed to build_command_line require quoting. If no quoting is require=
d,</div><div>extra quoting will essentially be ignored.</div><div><br></div=
><div>Perhaps a better solution would be to use execvp/execvpe, instead of<=
/div>

<div>flattening the the args to a string, only then have them parsed back</=
div><div>into arrays. That would be a more invasive change though, and I do=
n&#39;t</div><div>know if there are any cross-platform issues there.</div>

<div><br></div><div>This patch will make a backwards incompatible change fo=
r those have</div><div>hacked around this issue to get it to work. I would =
suspect that to be</div><div>few.</div><div>---</div><div>=A0src/plugins/do=
wn-root/down-root.c | =A0 15 +++++++++------</div>

<div>=A01 file changed, 9 insertions(+), 6 deletions(-)</div><div><br></div=
><div>diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-roo=
t/down-root.c</div><div>index d51d0e5..9594e4c 100644</div><div>--- a/src/p=
lugins/down-root/down-root.c</div>

<div>+++ b/src/plugins/down-root/down-root.c</div><div>@@ -233,7 +233,7 @@ =
build_command_line (const char *argv[])</div></div><div><div>=A0 =A0 =A0{</=
div><div>=A0 =A0 =A0 =A0for (i =3D 0; argv[i]; ++i)</div><div>=A0 { =A0 =A0=
</div><div>- =A0 size +=3D (strlen (argv[i]) + 1); /* string length plus tr=
ailing space */</div>

<div>+ =A0 size +=3D (strlen (argv[i]) + 3); /* string length plus quotes a=
nd trailing space */</div><div>=A0 =A0 ++n;</div><div>=A0 }=A0</div><div>=
=A0 =A0 =A0}</div><div>@@ -251,7 +251,9 @@ build_command_line (const char *=
argv[])</div><div>

=A0 =A0/* build string */</div><div>=A0 =A0for (i =3D 0; i &lt; n; ++i)</di=
v><div>=A0 =A0 =A0{=A0</div><div>+ =A0 =A0 =A0strcat (string, &quot;\&quot;=
&quot;);</div><div>=A0 =A0 =A0 =A0strcat (string, argv[i]);</div><div>+ =A0=
 =A0 =A0strcat (string, &quot;\&quot;&quot;);</div>

<div>=A0 =A0 =A0 =A0if (i + 1 &lt; n)</div><div>=A0 strcat (string, &quot; =
&quot;);</div><div>=A0 =A0 =A0}</div><div>@@ -455,7 +457,6 @@ openvpn_plugi=
n_abort_v1 (openvpn_plugin_handle_t handle)</div><div>=A0static void</div><=
div>=A0down_root_server (const int fd, char *command, const char *argv[], c=
onst char *envp[], const int verb)</div>

<div>=A0{</div><div>- =A0const char *p[3];</div><div>=A0 =A0char *command_l=
ine =3D NULL;</div><div>=A0 =A0char *argv_cat =3D NULL;</div><div>=A0 =A0in=
t i;</div><div>@@ -482,10 +483,12 @@ down_root_server (const int fd, char *=
command, const char *argv[], const char *e</div>

<div>=A0 =A0 =A0argv_cat =3D build_command_line (&amp;argv[1]);</div><div>=
=A0 =A0else</div><div>=A0 =A0 =A0argv_cat =3D build_command_line (NULL);</d=
iv><div>- =A0p[0] =3D command;</div><div>- =A0p[1] =3D argv_cat;</div><div>=
- =A0p[2] =3D NULL;</div><div>

- =A0command_line =3D build_command_line (p);</div><div>+</div><div>+ =A0co=
mmand_line =3D (char *) malloc (strlen(command) + strlen(argv_cat) + 2);</d=
iv><div>+ =A0*command_line =3D &#39;\0&#39;;</div><div>+ =A0strcat(command_=
line, command);</div>

<div>+ =A0strcat(command_line, &quot; &quot;);</div><div>+ =A0strcat(comman=
d_line, argv_cat);</div><div>=A0</div><div>=A0 =A0/*</div><div>=A0 =A0 * Sa=
ve envp in environment</div><div>-- =A0</div><div>1.7.10.4</div></div></div>

--001a11c30350d2133e04e9442193--

--001a11c30350d2134204e9442195
Content-Type: application/octet-stream; 
	name="0001-Properly-quote-command-and-arguments-passed-to-syste.patch"
Content-Disposition: attachment; 
	filename="0001-Properly-quote-command-and-arguments-passed-to-syste.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hn20l82d0

RnJvbSAxYzRlOTAyZmIxOTllZWRhYTA1NjgxZjRkMmUwYzliYTI3NzYzODFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNob2xhcyBIYWxsIDxuZ2hhcm9AZ21haWwuY29tPgpEYXRl
OiBNb24sIDIxIE9jdCAyMDEzIDEyOjU5OjQyIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gUHJvcGVy
bHkgcXVvdGUgY29tbWFuZCBhbmQgYXJndW1lbnRzIHBhc3NlZCB0byBzeXN0ZW0oKSBpbgogZG93
bi1yb290CgpTdXBwb3NlIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKb3BlbnZwbiAtLWNvbmZpZyBj
b25maWcgXAotLXBsdWdpbiAvdXNyL2xpYi9vcGVudnBuL29wZW52cG4tcGx1Z2luLWRvd24tcm9v
dC5zbyAiYmFzaCAtYwpcInNjcmlwdF90eXBlPWRvd24gY21kXCIiCgpPbmUgbWlnaHQgc3VzcGVj
dCB0aGF0IHRoaXMgd291bGQgZXZlbnR1YWxseSBjYWxsIGV4ZWN2ZSB3aXRoIGFuIGFycmF5Cmxp
a2U6IFsiYmFzaCIsICItYyIsICJzY3JpcHRfdHlwZT1kb3duIGNtZCJdLiBIb3dldmVyIHRoZSBh
cnJheSBwYXNzZWQKd291bGQgY3VycmVudGx5IGJlOiBbImJhc2giLCAiLWMiLCAic2NyaXB0X3R5
cGU9ZG93biIsICJjbWQiXQoKV2hhdCBoYXBwZW5zIGlzIHRoZSBwbHVnaW4gYXJndW1lbnQgcHJv
Y2Vzc2luZyB3aWxsIChldmVudHVhbGx5KSBwYXNzCmJhc2ggLWMgInNjcmlwdF90eXBlPWRvd24g
Y21kIiB0byBwYXJzZV9saW5lLCB3aGljaCB3aWxsIHBhcnNlIHRoZQpzdHJpbmcgdG8gYW4gYXJy
YXkgYXMgWyJiYXNoIiwgIi1jIiwgInNjcmlwdF90eXBlPWRvd24gY21kIl0gYW5kIHBhc3MgaXQK
YXMgdGhlIGFyZ3YgcGFyYW1ldGVyIHRvIGRvd24tcm9vdCdzIG9wZW52cG5fcGx1Z2luX29wZW5f
djEuIFNvIGZhciBzbwpnb29kLgoKVGhlbiBkb3duLXJvb3QgZmxhdHRlbnMgb3V0IHRoZSBhcnJh
eSB0byBhIHNpbmdsZSBzdHJpbmcgYnkgam9pbmluZyB0aGUKZWxlbWVudHMgd2l0aCBhIHNwYWNl
IHVzaW5nIGJ1aWxkX2NvbW1hbmRfbGluZS4gU28gdGhlbiB3ZSBnZXQgYmFzaCAtYwpzY3JpcHRf
dHlwZT1kb3duIGNtZC4gVGhpcyB3aWxsIGJlIGZlZCBhcyB0aGUgYXJndW1lbnQgdG8gc3lzdGVt
KCksCndoaWNoIGludGVybmFsbHkgcnVucyBzaCAtYyAnYmFzaCAtYyBzY3JpcHRfdHlwZT1kb3du
IGNtZCcuIFNvIGJhc2gKd291bGQgdGhlbiBydW4gdGhlIGNvbW1hbmQgc2NyaXB0X3R5cGU9ZG93
biB3aXRoIHRoZSBmaXJzdCBhcmd1bWVudCBvZgppdHMgYXJndW1lbnQgYXJyYXkgYmVpbmcgY21k
LCBub3Qgd2hhdCB3ZSBoYWQgd2FudGVkLgoKVGhlIHByb2JsZW0gaXMgZG93bi1yb290IHBsdWdp
bidzIGJ1aWxkX2NvbW1hbmRfbGluZSBhc3N1bWVzIHRoYXQgbm8KcXVvdGluZyBvZiBhcmd1bWVu
dHMgbmVlZHMgdG8gYmUgZG9uZS4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2FuIGJlCmhh
Y2tlZCBhcm91bmQgdG8gZ2V0IHRoZSBzZW1hbnRpY3Mgd2Ugd2FudCBoZXJlLCBob3dldmVyIHBy
b3ZpZGluZyB0aGUKcmlnaHQgZXNjYXBpbmcgcmVxdWlyZXMgZWl0aGVyIGx1Y2sgb3Iga25vd2xl
ZGdlIG9mIGhvdyBkb3duLXJvb3QgaXMKaW1wbGVtZW50ZWQuCgpUaGlzIHB1bGwgcmVxdWVzdCBm
aXhlcyB0aGlzIGJ5IGFzc3VtaW5nIHRoYXQgYWxsIGVsZW1lbnRzIG9mIHRoZSBhcnJheQpwYXNz
ZWQgdG8gYnVpbGRfY29tbWFuZF9saW5lIHJlcXVpcmUgcXVvdGluZy4gSWYgbm8gcXVvdGluZyBp
cyByZXF1aXJlZCwKZXh0cmEgcXVvdGluZyB3aWxsIGVzc2VudGlhbGx5IGJlIGlnbm9yZWQuCgpQ
ZXJoYXBzIGEgYmV0dGVyIHNvbHV0aW9uIHdvdWxkIGJlIHRvIHVzZSBleGVjdnAvZXhlY3ZwZSwg
aW5zdGVhZCBvZgpmbGF0dGVuaW5nIHRoZSB0aGUgYXJncyB0byBhIHN0cmluZywgb25seSB0aGVu
IGhhdmUgdGhlbSBwYXJzZWQgYmFjawppbnRvIGFycmF5cy4gVGhhdCB3b3VsZCBiZSBhIG1vcmUg
aW52YXNpdmUgY2hhbmdlIHRob3VnaCwgYW5kIEkgZG9uJ3QKa25vdyBpZiB0aGVyZSBhcmUgYW55
IGNyb3NzLXBsYXRmb3JtIGlzc3VlcyB0aGVyZS4KClRoaXMgcGF0Y2ggd2lsbCBtYWtlIGEgYmFj
a3dhcmRzIGluY29tcGF0aWJsZSBjaGFuZ2UgZm9yIHRob3NlIGhhdmUKaGFja2VkIGFyb3VuZCB0
aGlzIGlzc3VlIHRvIGdldCBpdCB0byB3b3JrLiBJIHdvdWxkIHN1c3BlY3QgdGhhdCB0byBiZQpm
ZXcuCi0tLQogc3JjL3BsdWdpbnMvZG93bi1yb290L2Rvd24tcm9vdC5jIHwgICAxNSArKysrKysr
KystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc3JjL3BsdWdpbnMvZG93bi1yb290L2Rvd24tcm9vdC5jIGIvc3JjL3Bs
dWdpbnMvZG93bi1yb290L2Rvd24tcm9vdC5jCmluZGV4IGQ1MWQwZTUuLjk1OTRlNGMgMTAwNjQ0
Ci0tLSBhL3NyYy9wbHVnaW5zL2Rvd24tcm9vdC9kb3duLXJvb3QuYworKysgYi9zcmMvcGx1Z2lu
cy9kb3duLXJvb3QvZG93bi1yb290LmMKQEAgLTIzMyw3ICsyMzMsNyBAQCBidWlsZF9jb21tYW5k
X2xpbmUgKGNvbnN0IGNoYXIgKmFyZ3ZbXSkKICAgICB7CiAgICAgICBmb3IgKGkgPSAwOyBhcmd2
W2ldOyArK2kpCiAJewotCSAgc2l6ZSArPSAoc3RybGVuIChhcmd2W2ldKSArIDEpOyAvKiBzdHJp
bmcgbGVuZ3RoIHBsdXMgdHJhaWxpbmcgc3BhY2UgKi8KKwkgIHNpemUgKz0gKHN0cmxlbiAoYXJn
dltpXSkgKyAzKTsgLyogc3RyaW5nIGxlbmd0aCBwbHVzIHF1b3RlcyBhbmQgdHJhaWxpbmcgc3Bh
Y2UgKi8KIAkgICsrbjsKIAl9CiAgICAgfQpAQCAtMjUxLDcgKzI1MSw5IEBAIGJ1aWxkX2NvbW1h
bmRfbGluZSAoY29uc3QgY2hhciAqYXJndltdKQogICAvKiBidWlsZCBzdHJpbmcgKi8KICAgZm9y
IChpID0gMDsgaSA8IG47ICsraSkKICAgICB7CisgICAgICBzdHJjYXQgKHN0cmluZywgIlwiIik7
CiAgICAgICBzdHJjYXQgKHN0cmluZywgYXJndltpXSk7CisgICAgICBzdHJjYXQgKHN0cmluZywg
IlwiIik7CiAgICAgICBpZiAoaSArIDEgPCBuKQogCXN0cmNhdCAoc3RyaW5nLCAiICIpOwogICAg
IH0KQEAgLTQ1NSw3ICs0NTcsNiBAQCBvcGVudnBuX3BsdWdpbl9hYm9ydF92MSAob3BlbnZwbl9w
bHVnaW5faGFuZGxlX3QgaGFuZGxlKQogc3RhdGljIHZvaWQKIGRvd25fcm9vdF9zZXJ2ZXIgKGNv
bnN0IGludCBmZCwgY2hhciAqY29tbWFuZCwgY29uc3QgY2hhciAqYXJndltdLCBjb25zdCBjaGFy
ICplbnZwW10sIGNvbnN0IGludCB2ZXJiKQogewotICBjb25zdCBjaGFyICpwWzNdOwogICBjaGFy
ICpjb21tYW5kX2xpbmUgPSBOVUxMOwogICBjaGFyICphcmd2X2NhdCA9IE5VTEw7CiAgIGludCBp
OwpAQCAtNDgyLDEwICs0ODMsMTIgQEAgZG93bl9yb290X3NlcnZlciAoY29uc3QgaW50IGZkLCBj
aGFyICpjb21tYW5kLCBjb25zdCBjaGFyICphcmd2W10sIGNvbnN0IGNoYXIgKmUKICAgICBhcmd2
X2NhdCA9IGJ1aWxkX2NvbW1hbmRfbGluZSAoJmFyZ3ZbMV0pOwogICBlbHNlCiAgICAgYXJndl9j
YXQgPSBidWlsZF9jb21tYW5kX2xpbmUgKE5VTEwpOwotICBwWzBdID0gY29tbWFuZDsKLSAgcFsx
XSA9IGFyZ3ZfY2F0OwotICBwWzJdID0gTlVMTDsKLSAgY29tbWFuZF9saW5lID0gYnVpbGRfY29t
bWFuZF9saW5lIChwKTsKKworICBjb21tYW5kX2xpbmUgPSAoY2hhciAqKSBtYWxsb2MgKHN0cmxl
bihjb21tYW5kKSArIHN0cmxlbihhcmd2X2NhdCkgKyAyKTsKKyAgKmNvbW1hbmRfbGluZSA9ICdc
MCc7CisgIHN0cmNhdChjb21tYW5kX2xpbmUsIGNvbW1hbmQpOworICBzdHJjYXQoY29tbWFuZF9s
aW5lLCAiICIpOworICBzdHJjYXQoY29tbWFuZF9saW5lLCBhcmd2X2NhdCk7CiAKICAgLyoKICAg
ICogU2F2ZSBlbnZwIGluIGVudmlyb25tZW50Ci0tIAoxLjcuMTAuNAoK
--001a11c30350d2134204e9442195--

