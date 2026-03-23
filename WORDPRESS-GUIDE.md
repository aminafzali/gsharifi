# راهنمای استفاده در وردپرس - پت وت

این راهنما نحوه پیاده‌سازی طرح پت وت در وردپرس را به صورت گام به گام توضیح می‌دهد.

## 📋 فهرست مطالب

1. [پیش‌نیازها](#پیش-نیازها)
2. [روش اول: استفاده از Page Builder](#روش-اول-page-builder)
3. [روش دوم: Template سفارشی](#روش-دوم-template-سفارشی)
4. [روش سوم: افزونه Custom HTML](#روش-سوم-افزونه-custom-html)
5. [تنظیمات پیشرفته](#تنظیمات-پیشرفته)

## 🔧 پیش‌نیازها

قبل از شروع، مطمئن شوید که:

- ✅ وردپرس نسخه 5.0 یا بالاتر نصب شده باشد
- ✅ دسترسی به پنل مدیریت وردپرس دارید
- ✅ قابلیت ویرایش فایل‌های تم را دارید
- ✅ یک تم وردپرس فعال دارید

## 🎨 روش اول: Page Builder

این روش برای کسانی که با کد آشنایی ندارند، مناسب است.

### با Elementor

#### مرحله 1: نصب Elementor

```
Dashboard → Plugins → Add New → جستجوی "Elementor" → Install → Activate
```

#### مرحله 2: ایجاد صفحه جدید

```
Pages → Add New → عنوان: "صفحه اصلی" → Edit with Elementor
```

#### مرحله 3: افزودن HTML سفارشی

1. در Elementor، یک ویجت "HTML" را drag & drop کنید
2. محتوای `<body>` از فایل `index.html` را کپی کنید
3. در ویجت HTML پیست کنید

#### مرحله 4: افزودن CSS

1. در Elementor، به **Site Settings** بروید
2. **Custom CSS** را باز کنید
3. محتوای فایل `styles.css` را کپی و پیست کنید

#### مرحله 5: افزودن JavaScript

1. افزونه "Insert Headers and Footers" را نصب کنید
2. به **Settings → Insert Headers and Footers** بروید
3. در بخش "Scripts in Footer"، این کد را اضافه کنید:

```html
<script src="https://cdn.tailwindcss.com"></script>
<script>
// محتوای فایل script.js را اینجا قرار دهید
</script>
```

#### مرحله 6: تنظیم به عنوان صفحه اصلی

```
Settings → Reading → Homepage displays: A static page → Homepage: صفحه اصلی
```

### با WPBakery

مراحل مشابه Elementor است، فقط به جای ویجت HTML از **Raw HTML** استفاده کنید.

### با Gutenberg (ویرایشگر پیش‌فرض وردپرس)

1. بلاک **Custom HTML** را اضافه کنید
2. کد HTML را پیست کنید
3. برای CSS و JS از روش‌های زیر استفاده کنید

## 💻 روش دوم: Template سفارشی

این روش برای توسعه‌دهندگان پیشنهاد می‌شود.

### مرحله 1: ساخت فایل Template

در پوشه تم خود (`wp-content/themes/your-theme/`):

#### فایل `template-petvet.php`:

```php
<?php
/**
 * Template Name: PetVet Homepage
 * Description: صفحه اصلی پت وت با طراحی سفارشی
 */

get_header(); 
?>

<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php bloginfo('name'); ?> - <?php bloginfo('description'); ?></title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Vazirmatn:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="<?php echo get_template_directory_uri(); ?>/css/petvet-styles.css">
    
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>

<!-- محتوای HTML از فایل index.html را اینجا قرار دهید -->
<!-- فقط بخش <body> را کپی کنید، نه کل فایل -->

<?php wp_footer(); ?>

<!-- Custom Scripts -->
<script src="<?php echo get_template_directory_uri(); ?>/js/petvet-script.js"></script>

</body>
</html>

<?php
get_footer();
?>
```

### مرحله 2: ساخت پوشه‌ها و فایل‌ها

در پوشه تم:

```
your-theme/
├── css/
│   └── petvet-styles.css     (محتوای styles.css را کپی کنید)
├── js/
│   └── petvet-script.js      (محتوای script.js را کپی کنید)
└── template-petvet.php        (فایل بالا)
```

### مرحله 3: Enqueue کردن فایل‌ها

در فایل `functions.php`:

```php
<?php
/**
 * Enqueue PetVet Styles and Scripts
 */
function petvet_enqueue_assets() {
    // فقط برای صفحاتی که از template استفاده می‌کنند
    if (is_page_template('template-petvet.php')) {
        
        // Tailwind CSS از CDN
        wp_enqueue_script(
            'tailwindcss',
            'https://cdn.tailwindcss.com',
            array(),
            null,
            false
        );
        
        // Google Fonts
        wp_enqueue_style(
            'vazirmatn-font',
            'https://fonts.googleapis.com/css2?family=Vazirmatn:wght@300;400;500;600;700;800&display=swap',
            array(),
            null
        );
        
        // Custom Styles
        wp_enqueue_style(
            'petvet-styles',
            get_template_directory_uri() . '/css/petvet-styles.css',
            array(),
            '1.0.0'
        );
        
        // Custom Scripts
        wp_enqueue_script(
            'petvet-script',
            get_template_directory_uri() . '/js/petvet-script.js',
            array(),
            '1.0.0',
            true
        );
    }
}
add_action('wp_enqueue_scripts', 'petvet_enqueue_assets');

/**
 * اضافه کردن فیلترهای وردپرس
 */
function petvet_add_filters() {
    // حذف آدرس سایت از لینک‌ها (اختیاری)
    add_filter('wp_nav_menu_args', function($args) {
        $args['container'] = false;
        return $args;
    });
}
add_action('init', 'petvet_add_filters');
?>
```

### مرحله 4: ایجاد صفحه

1. **Pages → Add New**
2. عنوان: "صفحه اصلی پت وت"
3. در قسمت **Page Attributes → Template** گزینه "PetVet Homepage" را انتخاب کنید
4. **Publish** کنید

### مرحله 5: تنظیم به عنوان صفحه اصلی

```
Settings → Reading → Homepage displays: A static page
→ Homepage: صفحه اصلی پت وت
```

## 🔌 روش سوم: افزونه Custom HTML

### مرحله 1: نصب افزونه

```
Plugins → Add New → جستجوی "Insert Headers and Footers"
→ Install Now → Activate
```

### مرحله 2: اضافه کردن کدها

به **Settings → Insert Headers and Footers** بروید:

#### بخش "Scripts in Header":

```html
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Vazirmatn:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Custom Styles -->
<style>
/* محتوای فایل styles.css را اینجا قرار دهید */
</style>
```

#### بخش "Scripts in Footer":

```html
<script>
// محتوای فایل script.js را اینجا قرار دهید
</script>
```

### مرحله 3: ایجاد صفحه با HTML Block

1. صفحه جدید ایجاد کنید
2. بلاک **Custom HTML** اضافه کنید
3. محتوای `<body>` از `index.html` را پیست کنید

## ⚙️ تنظیمات پیشرفته

### یکپارچه‌سازی با منوی وردپرس

در فایل `template-petvet.php`، بخش منو را با این کد جایگزین کنید:

```php
<nav class="hidden lg:flex items-center space-x-reverse space-x-8">
    <?php
    wp_nav_menu(array(
        'theme_location' => 'primary',
        'container' => false,
        'menu_class' => 'flex items-center space-x-reverse space-x-8',
        'link_before' => '<span class="nav-link text-gray-700 hover:text-[#4A90A4] transition-colors font-medium">',
        'link_after' => '</span>',
    ));
    ?>
</nav>
```

و در `functions.php`:

```php
function petvet_register_menus() {
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'petvet'),
    ));
}
add_action('after_setup_theme', 'petvet_register_menus');
```

### استفاده از WordPress Media Library

برای تصاویر، به جای URL ثابت:

```php
<?php
$image_id = get_post_thumbnail_id();
$image_url = wp_get_attachment_image_url($image_id, 'full');
?>
<img src="<?php echo esc_url($image_url); ?>" alt="<?php the_title(); ?>">
```

### Dynamic Content

برای محتوای پویا:

```php
<!-- عنوان -->
<h1><?php the_title(); ?></h1>

<!-- محتوا -->
<div class="content">
    <?php the_content(); ?>
</div>

<!-- تاریخ -->
<span><?php echo get_the_date(); ?></span>
```

### Custom Post Types برای خدمات

در `functions.php`:

```php
function petvet_register_service_post_type() {
    $args = array(
        'label' => 'خدمات',
        'public' => true,
        'supports' => array('title', 'editor', 'thumbnail'),
        'has_archive' => true,
        'menu_icon' => 'dashicons-heart',
    );
    register_post_type('service', $args);
}
add_action('init', 'petvet_register_service_post_type');
```

سپس در template:

```php
<?php
$services = new WP_Query(array(
    'post_type' => 'service',
    'posts_per_page' => 6,
));

if ($services->have_posts()) :
    while ($services->have_posts()) : $services->the_post();
?>
    <div class="service-card">
        <h3><?php the_title(); ?></h3>
        <div><?php the_content(); ?></div>
    </div>
<?php
    endwhile;
    wp_reset_postdata();
endif;
?>
```

## 🎨 سفارشی‌سازی تم

### افزودن تنظیمات تم

در `functions.php`:

```php
function petvet_customizer_settings($wp_customize) {
    
    // بخش رنگ‌ها
    $wp_customize->add_section('petvet_colors', array(
        'title' => __('رنگ‌های پت وت', 'petvet'),
        'priority' => 30,
    ));
    
    // رنگ اصلی
    $wp_customize->add_setting('petvet_primary_color', array(
        'default' => '#4A90A4',
        'transport' => 'refresh',
    ));
    
    $wp_customize->add_control(new WP_Customize_Color_Control($wp_customize, 'petvet_primary_color', array(
        'label' => __('رنگ اصلی', 'petvet'),
        'section' => 'petvet_colors',
    )));
    
    // رنگ ثانویه
    $wp_customize->add_setting('petvet_secondary_color', array(
        'default' => '#5FA8BC',
        'transport' => 'refresh',
    ));
    
    $wp_customize->add_control(new WP_Customize_Color_Control($wp_customize, 'petvet_secondary_color', array(
        'label' => __('رنگ ثانویه', 'petvet'),
        'section' => 'petvet_colors',
    )));
}
add_action('customize_register', 'petvet_customizer_settings');
```

### استفاده از رنگ‌های سفارشی

در فایل CSS:

```php
<style>
:root {
    --primary-color: <?php echo get_theme_mod('petvet_primary_color', '#4A90A4'); ?>;
    --secondary-color: <?php echo get_theme_mod('petvet_secondary_color', '#5FA8BC'); ?>;
}
</style>
```

## 🔒 امنیت و بهینه‌سازی

### امنیت

```php
// در تمام خروجی‌ها از escape استفاده کنید
<?php echo esc_html(get_the_title()); ?>
<?php echo esc_url(get_permalink()); ?>
<?php echo esc_attr(get_post_meta($post_id, 'key', true)); ?>
```

### بهینه‌سازی

```php
// Lazy Loading برای تصاویر
<img src="..." loading="lazy" alt="...">

// Minify CSS و JS
function petvet_minify_output() {
    ob_start(function($html) {
        return preg_replace('/\s+/', ' ', $html);
    });
}
add_action('template_redirect', 'petvet_minify_output');
```

### Cache

از افزونه‌های cache استفاده کنید:
- W3 Total Cache
- WP Super Cache
- WP Rocket (Premium)

## 📱 تست و دیباگ

### حالت Debug

در `wp-config.php`:

```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

### بررسی مشکلات

```php
// در functions.php
error_log('متغیر: ' . print_r($variable, true));
```

### تست ریسپانسیو

- موبایل: Chrome DevTools (F12)
- واقعی: BrowserStack, LambdaTest

## 🚀 انتشار

### Checklist قبل از انتشار

- [ ] تمام لینک‌ها کار می‌کنند
- [ ] تصاویر بهینه شده‌اند
- [ ] فرم‌ها تست شده‌اند
- [ ] SEO بهینه است
- [ ] سرعت بارگذاری مناسب است
- [ ] روی موبایل تست شده
- [ ] با مرورگرهای مختلف تست شده

### بهینه‌سازی نهایی

```bash
# فشرده‌سازی تصاویر
# استفاده از ImageOptim, TinyPNG

# Minify CSS & JS
# استفاده از Autoptimize

# Enable Gzip
# در .htaccess
```

## 💡 نکات و ترفندها

### استفاده از Shortcodes

```php
function petvet_hero_shortcode() {
    ob_start();
    include get_template_directory() . '/template-parts/hero.php';
    return ob_get_clean();
}
add_shortcode('petvet_hero', 'petvet_hero_shortcode');

// استفاده: [petvet_hero]
```

### افزودن Widgets

```php
function petvet_widgets_init() {
    register_sidebar(array(
        'name' => 'Sidebar اصلی',
        'id' => 'sidebar-1',
        'before_widget' => '<div class="widget">',
        'after_widget' => '</div>',
    ));
}
add_action('widgets_init', 'petvet_widgets_init');
```

## 🆘 مشکلات رایج

### مشکل 1: CSS/JS لود نمی‌شود

**راه حل:**
```php
// مطمئن شوید wp_head() و wp_footer() فراخوانی شده‌اند
// در header.php قبل از </head>
<?php wp_head(); ?>

// در footer.php قبل از </body>
<?php wp_footer(); ?>
```

### مشکل 2: Tailwind کار نمی‌کند

**راه حل:**
- CDN را چک کنید
- یا Tailwind را به صورت لوکال نصب کنید

### مشکل 3: انیمیشن‌ها روی موبایل کند است

**راه حل:**
```css
@media (max-width: 768px) {
    * {
        animation-duration: 0.3s !important;
    }
}
```

## 📞 پشتیبانی

برای سوالات بیشتر:
- مستندات وردپرس: https://codex.wordpress.org/
- Stack Overflow: https://stackoverflow.com/
- فروم‌های فارسی وردپرس

---

موفق باشید! 🚀

