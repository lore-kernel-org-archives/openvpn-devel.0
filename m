Message-ID: <50F6C33F.1070405@...1227...>
Date: Wed, 16 Jan 2013 16:11:59 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CADaK0BzLjzS8x82+pqKfNH02Hde9pNVneGY5sv6W8y0qcYMDVw@...278...>
In-Reply-To: <CADaK0BzLjzS8x82+pqKfNH02Hde9pNVneGY5sv6W8y0qcYMDVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] OpenVpn For Android 4.0: Passing OVPN
 configuration to application through 3rd party app via Intent
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alok Kulkarni <kulsuhas@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 16.01.13 15:32, schrieb Alok Kulkarni:
> Hi,I am writing an Android application which needs to Connect to
> OpenVpn server using OpnVpn for Android.
> I need to pass OVPN configuration to OpenVpn For Android app through
> my application.
> I can pass the Ovpn file path(Stored on SDcard) to
> de.blinkt.openvpn.ConfigConverter.java class through Intent , but i
> need a more secure way as i do not want to store the configuration
> file on SDcard. I can create the OVPN file through my application and
> pass it to ConfigConverter class as a String using Intent
>
> I am inserting the code changes to onStart() method in
> ConfigConverter.java class below as well as attaching the entire java
> file with this mail.
Thanks for the code. While I have no doubt that this code will work I
don't think that it is feasible to include the current form into the
application. The code uses no authentication or validity checking which
can lead to the confused deputy problem. I am working on more secure
solution but cannot give you an ETA when it is done. Not that in current
you can trigger the config import by using an application/ovpn intent
and start the profile if you know the name.

Arne

