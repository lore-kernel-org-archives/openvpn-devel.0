References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
 <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
From: Ton van Vliet <epposan@...277...>
Message-ID: <6b2de5c1-99b7-406f-04d5-bb9449d120b9@...277...>
Date: Sun, 3 Nov 2019 23:04:29 +0100
MIME-Version: 1.0
In-Reply-To: <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
Content-Type: multipart/alternative;
 boundary="------------9D848B34716BA8AD5B211A2C"
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------9D848B34716BA8AD5B211A2C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

Thanks for the additional tips.

I already replied to Samuli yesterday, but only now noticed that I did not reply to the list.

I did play around with pnputil (Samuli is using it in his script as well), but was not able to remove all drivers with it: some were 'in use', while others were listed but somehow 'invalid'.

Only after I uninstalled tap-windows6, I was able to remove the 'in use' ones. The other ones were leftover oem<x>.inf files from earlier failing installs.

I had to re-instantiate all TAP-devices after this, but all is fine now.

Normally I would prefer to troubleshoot, however, since I apparently am the only one with the problem, I took Samuli's shortcut and uninstalled tap-windows6

Best regards,
Ton

On 03-11-19 17:18, Simon Rozman wrote:

> Hi Ton,
>
> You can also use pnputil.exe (in an elevated command prompt) to check version, uninstall, and/or install TAP driver manually. The pnputil is a stock command line utility for driver management on all Windows.
>
> I advise you use pnputil to list all your installed TAP-Windows6 drivers - yes, there may be more than one version installed.  Carefully uninstall all TAP-Windows6 drivers. "Carefully" in a sense that you pay extra attention to delete oem<nn>.inf entries corresponding to the TAP-Windows6, and not your graphics card or disk controller.  Note that network interface settings are stored elsewhere in registry and uninstalling the driver will not delete them. Your TAP interfaces will just disappear for a while. You already noticed that phenomena before.
>
> Next, install the latest driver - you can use the official installer. Or - if you already have it installed - find a copy of the driver in C:\Program Files\TAP-Windows6\driver (your path may vary) and use pnputil to install the driver. Or - right click on the .inf file and select Install. Your TAP interfaces should reappear.
>
> Also, since you're troubleshooting, I'd strongly advise you to reboot in between.
>
> Best regards,
> Simon


--------------9D848B34716BA8AD5B211A2C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Hi Simon,

Thanks for the additional tips.

I already replied to Samuli yesterday, but only now noticed that I did not reply to the list.

I did play around with pnputil (Samuli is using it in his script as well), but was not able to remove all drivers with it: some were 'in use', while others were listed but somehow 'invalid'.

Only after I uninstalled tap-windows6, I was able to remove the 'in use' ones. The other ones were leftover oem&lt;x&gt;.inf files from earlier failing installs.

I had to re-instantiate all TAP-devices after this, but all is fine now.
<pre>Normally I would prefer to troubleshoot, however, since I apparently am the only one with the problem, I took Samuli's shortcut and uninstalled tap-windows6

Best regards,
Ton</pre></pre>
    <div class="moz-cite-prefix">
      <pre>On 03-11-19 17:18, Simon Rozman wrote:</pre>
    </div>
    <blockquote type="cite"
      cite="mid:AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...">
      <pre class="moz-quote-pre" wrap="">Hi Ton,

You can also use pnputil.exe (in an elevated command prompt) to check version, uninstall, and/or install TAP driver manually. The pnputil is a stock command line utility for driver management on all Windows.

I advise you use pnputil to list all your installed TAP-Windows6 drivers - yes, there may be more than one version installed.  Carefully uninstall all TAP-Windows6 drivers. "Carefully" in a sense that you pay extra attention to delete oem&lt;nn&gt;.inf entries corresponding to the TAP-Windows6, and not your graphics card or disk controller.  Note that network interface settings are stored elsewhere in registry and uninstalling the driver will not delete them. Your TAP interfaces will just disappear for a while. You already noticed that phenomena before.

Next, install the latest driver - you can use the official installer. Or - if you already have it installed - find a copy of the driver in C:\Program Files\TAP-Windows6\driver (your path may vary) and use pnputil to install the driver. Or - right click on the .inf file and select Install. Your TAP interfaces should reappear.

Also, since you're troubleshooting, I'd strongly advise you to reboot in between.

Best regards,
Simon
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9D848B34716BA8AD5B211A2C--

