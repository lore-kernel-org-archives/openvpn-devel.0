From: Simon Rozman <simon@...2293...>
Date: Wed, 6 Dec 2017 17:18:26 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE1085B4CA9F@...2294...>
References: <1512534521-14760-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1512534521-14760-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Refactor get_interface_metric to return
 metric and auto flag separately
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "selva.nair@...277..." <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I have briefly reviewed this patch. If you look at each get_interface_metri=
c() call you'll notice exactly the same repeating pattern:

        tap_metric_v4 =3D get_interface_metric(index, AF_INET, &is_auto);
        if (is_auto)
        {
            tap_metric_v4 =3D 0;
        }
        tap_metric_v6 =3D get_interface_metric(index, AF_INET6, &is_auto);
        if (is_auto)
        {
            tap_metric_v6 =3D 0;
        }

Should the get_interface_metric() be rewritten to return:
0 =3D automatic metric
n =3D manual metric
-1 =3D error

...all the get_interface_metric() would simplify to:

        tap_metric_v4 =3D get_interface_metric(index, AF_INET);
        tap_metric_v6 =3D get_interface_metric(index, AF_INET6);

Just a suggestion.

Best regards,
Simon

