MIME-Version: 1.0
References: <20230315013516.1256700-2-selva.nair@...277...>
 <202303160927.32G9RIoZ066276@...2054...>
In-Reply-To: <202303160927.32G9RIoZ066276@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 16 Mar 2023 07:59:42 -0400
Message-ID: <CAKuzo_isnor9ZsohVH__n-JGnFi6tqqLwSfT07GMU6pVJZYHwg@...278...>
Content-Type: multipart/alternative; boundary="00000000000026df7e05f7033305"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Import some sample
 certificates into Windows store for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000026df7e05f7033305
Content-Type: text/plain; charset="UTF-8"

>
>
> I have tried testing this on a "real" Win10 VM, but I am missing some
> intricacies with the cert store - I wanted to see if certs are properly
> cleaned up, but I can't even see my own .p12 I have imported, so I am
> doing something wrong...


This works for me:
Run "certmgr" from a user command prompt. The UI that opens up will show
the "Certificates - Current User" snapin. Under it select
"Personal->Certificates", and a list of all imported certificates will open
up. This will not include any Root certificates that may have been
imported. Those go to "Trusted Root Certificates" listed below "Personal".

I'm not entirely sure whether it's possible to select a wrong destination
during import, causing client certificates to go into root certificates.
During import I only select the store (user or machine) and let it decide
the appropriate location within the store.

Selva

--00000000000026df7e05f7033305
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
I have tried testing this on a &quot;real&quot; Win10 VM, but I am missing =
some<br>
intricacies with the cert store - I wanted to see if certs are properly<br>
cleaned up, but I can&#39;t even see my own .p12 I have imported, so I am<b=
r>
doing something wrong...</blockquote><div><br></div><div>This works for me:=
=C2=A0</div><div>Run &quot;certmgr&quot; from a user command prompt. The UI=
 that opens up will show the &quot;Certificates - Current User&quot; snapin=
. Under it select &quot;Personal-&gt;Certificates&quot;, and a list of all =
imported certificates will open up. This will not include any Root certific=
ates that may have been imported. Those go to &quot;Trusted Root Certificat=
es&quot; listed below &quot;Personal&quot;.=C2=A0</div><div><br></div><div>=
I&#39;m not entirely sure whether it&#39;s possible to select a wrong desti=
nation during import, causing=C2=A0client=C2=A0certificates to go into root=
 certificates. During import I only select the store (user or machine) and =
let it decide the appropriate location within the store.</div><div><br></di=
v><div>Selva</div></div></div>

--00000000000026df7e05f7033305--

